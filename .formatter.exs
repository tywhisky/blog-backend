[
  import_deps: [:ecto, :phoenix, :plug, :absinthe, :ecto_sql],
  inputs: ["*.{ex,exs}", "priv/*/seeds.exs", "{config,lib,test}/**/*.{ex,exs}"],
  subdirectories: ["priv/*/migrations"],
  locals_without_parens: [
    oban_dashboard: 1,
    service: 1,
    service: 2,
    redact_field: 2,
    redact_field: 3
  ]
]
