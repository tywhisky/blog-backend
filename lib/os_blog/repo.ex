defmodule OsBlog.Repo do
  use Ecto.Repo,
    otp_app: :os_blog,
    adapter: Ecto.Adapters.Postgres
end
