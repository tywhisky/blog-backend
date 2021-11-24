defmodule OsBlog.Utils do
  @moduledoc false

  @alpha_up "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  @alpha_down String.downcase(@alpha_up)
  @numbers "0123456789"
  @chars (@alpha_up <> @alpha_down <> @numbers) |> String.split("", trim: true)
  @phone_num_reg ~r/1\d{10}$/

  def env(key) do
    Application.get_env(:os_blog, key)
  end

  def env(key, sub_key) do
    Application.get_env(:os_blog, key, []) |> Keyword.get(sub_key)
  end

  def trim_field(value) when is_binary(value) do
    case String.trim(value) do
      "" -> nil
      val -> val
    end
  end

  def trim_field(_value), do: nil

  def downcase_field(value) when is_binary(value), do: String.downcase(value)
  def downcase_field(value), do: value

  @doc """
  生成随机字符串，包含大小写字母和数字

  参数：

    * `length` - 必填。字符串长度

  """
  def random_str(opts) do
    len = Keyword.fetch!(opts, :length)
    Enum.map_join(1..len, fn _ -> Enum.random(@chars) end)
  end

  def prefix_error_codes(prefix, codes) do
    Enum.map(codes, &:"#{prefix}_#{&1}")
  end

  def time_expired?(time, option) do
    time
    |> Timex.shift(option)
    |> Timex.before?(Timex.now())
  end

  def check_phone_num_format(phone_num) when is_binary(phone_num) do
    if Regex.match?(@phone_num_reg, phone_num) do
      :ok
    else
      {:error, :invalid_phone_number_error}
    end
  end

  def check_phone_num_format(_), do: {:error, :invalid_phone_number_error}

  @doc """
  显示 struct 的模块名，通常用于转成 string 做持久化
  """
  def struct_mod_name(struct) do
    struct.__struct__ |> Atom.to_string() |> String.replace_prefix("Elixir.", "")
  end

  def phone_num_regex do
    @phone_num_reg
  end

  def get_create_date(struct), do: Timex.format!(struct.inserted_at, "{YYYY}-{0M}")

  @doc """
  将 struct 或 map 递归解析为 map

  ## Options

    * `drop_keys` - 删除原有 struct 或 map 中的字段，可以删除特定 struct 下的字段。

  ## Examples

    iex> to_map(post, drop_keys: [[:id]])
    iex> to_map(post, drop_keys: [{Post, [:id]}])
    iex> to_map(post, drop_keys: [{Post, [:id]}, {Comment, [:id, :post_id]}])

  """
  @spec to_map(
          struct() | map(),
          opts :: [drop_keys: [key :: atom()] | [{module :: atom, [key :: atom()]}]]
        ) :: map()
  def to_map(struct_or_map, opts \\ [])

  def to_map(struct_or_map, opts) when is_map(struct_or_map) or is_struct(struct_or_map),
    do: convert_to_map(struct_or_map, opts)

  def to_map(_, _opts), do: raise(ArgumentError)

  # DateTime 特殊处理不做转换，会影响时间解析
  defp convert_to_map(%DateTime{} = date_time, _), do: date_time
  defp convert_to_map(%NaiveDateTime{} = date_time, _), do: date_time

  defp convert_to_map(struct, opts) when is_struct(struct) do
    drop_keys = [:__struct__, :__meta__] ++ drop_keys(struct, opts)

    struct
    |> Map.from_struct()
    |> Enum.reject(fn
      {_key, %Ecto.Association.NotLoaded{}} -> true
      {key, _val} -> key in drop_keys
    end)
    |> Enum.map(fn {key, val} -> {key, convert_to_map(val, opts)} end)
    |> Map.new()
  end

  defp convert_to_map(map, opts) when is_map(map) do
    drop_keys = drop_keys(map, opts)

    map
    |> Enum.reject(fn {key, _val} -> key in drop_keys end)
    |> Enum.map(fn {key, val} ->
      {key, convert_to_map(val, opts)}
    end)
    |> Map.new()
  end

  defp convert_to_map(list, opts) when is_list(list) do
    Enum.map(list, &convert_to_map(&1, opts))
  end

  defp convert_to_map(value, _opts), do: value

  def drop_keys(%module{}, opts) do
    keys = Keyword.get(opts, :drop_keys, [])
    if Keyword.keyword?(keys), do: Keyword.get(keys, module, []), else: keys
  end

  def drop_keys(_map, opts) do
    Keyword.get(opts, :drop_keys, [])
  end

  @doc """
  序列化任意数据结构成字符串格式。
  """
  def encode_data(data, convert_func \\ &:erlang.term_to_binary/1)

  def encode_data(nil, _), do: nil

  def encode_data(data, convert_func) do
    data |> convert_func.() |> :zlib.compress() |> Base.encode64()
  end

  @doc """
  把 `encode_data/2` 的结果反序列化回数据。
  """
  def decode_data(data, convert_func \\ &:erlang.binary_to_term/1)

  def decode_data(nil, _), do: nil

  def decode_data(data, convert_func) do
    data |> Base.decode64!() |> :zlib.uncompress() |> convert_func.()
  end

  def set_pos(list, field \\ :pos) when is_list(list) do
    list
    |> Enum.with_index(1)
    |> Enum.map(fn {item, idx} ->
      Map.put(item, field, idx)
    end)
  end

  # DateTime 特殊处理不做转换，会影响时间解析
  def to_string_keys(%DateTime{} = date_time), do: date_time
  def to_string_keys(%NaiveDateTime{} = date_time), do: date_time

  def to_string_keys(list) when is_list(list) do
    Enum.map(list, &to_string_keys(&1))
  end

  def to_string_keys(map) when is_map(map) do
    map
    |> Enum.map(fn {key, val} -> {to_string(key), to_string_keys(val)} end)
    |> Map.new()
  end

  def to_string_keys(value), do: value

  def timestamp(%DateTime{} = datetime) do
    DateTime.to_unix(datetime, :millisecond)
  end
end
