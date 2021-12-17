defmodule OsBlog.Tags.Tag do
  use OsBlog, :schema

  @type t :: %__MODULE__{}

  schema "tags" do
    field :name, :string

    timestamps(type: :utc_datetime_usec)
  end

  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
