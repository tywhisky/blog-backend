# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     OsBlog.Repo.insert!(%OsBlog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias OsBlog.Managers.Manager
alias OsBlog.SystemInfos.SystemInfo
alias OsBlog.Repo

if Mix.env() == :dev do
  manager_params = %{
    name: "manager",
    email: "manager@dev.com",
    password: "123456",
  }

  %Manager{}
  |> Manager.create_changeset(manager_params)
  |> Repo.insert!()

  system_info_params = %{
    site_name: "My Blog",
    site_desc: "It's my blog.",
    site_logo: "http://localhost:8080",
    favicon: "http://localhost:8080",
    foot_about: "foot_about",
    foot_filing: "foot_filing",
    foot_copy_right: "foot_copy_right",
    foot_powered_by: "foot_powered_by",
    foot_powered_by_url: "foot_powered_by_url"
  }

  %SystemInfo{}
  |> SystemInfo.update_changeset(system_info_params)
  |> Repo.insert!()

  Mix.shell().info([:light_blue, :light_magenta_background, "Administrator account has created! account: manager@dev.com password: 123456"])
end
