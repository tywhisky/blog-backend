defmodule Phxtemplate.Repo do
  use Ecto.Repo,
    otp_app: :phxtemplate,
    adapter: Ecto.Adapters.Postgres
end
