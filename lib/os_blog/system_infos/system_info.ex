defmodule OsBlog.SystemInfos.SystemInfo do
  use OsBlog, :schema

  schema "system_info" do
    field :site_name, :string
    field :site_desc, :string
    field :site_logo, :string
    field :favicon, :string
    field :foot_about, :string
    field :foot_filing, :string
    field :foot_copy_right, :string
    field :foot_powered_by, :string
    field :foot_powered_by_url, :string
    timestamps()
  end

  def update_changeset(system_info, attrs) do
    system_info
    |> cast(attrs, [
      :site_name,
      :site_desc,
      :site_logo,
      :favicon,
      :foot_about,
      :foot_filing,
      :foot_copy_right,
      :foot_powered_by,
      :foot_powered_by_url
    ])
  end
end
