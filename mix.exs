defmodule Chess.Mixfile do
  use Mix.Project

  def project do
    [
      app: :chess,
      version: "0.2.0",
      elixir: "~> 1.6.6",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps(),
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Chess, []},
      extra_applications: [:logger],
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support", "test/helpers"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:argon2_elixir, "~> 1.3"},
      {:bamboo, "~> 1.0"},
      {:comeonin, "~> 4.0"},
      {:cowboy, "~> 1.0"},
      {:credo, "~> 1.0", only: [:dev, :test]},
      {:distillery, "~> 2.0", runtime: false},
      {:formulator, "~> 0.1.6"},
      {:gettext, "~> 0.16.0"},
      {:guardian, "~> 1.0"},
      {:phoenix, "~> 1.4.10"},
      {:phoenix_ecto, "~> 3.0"},
      {:phoenix_html, "~> 2.0"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:phoenix_pubsub, "~> 1.0"},
      {:postgrex, ">= 0.0.0"},
      {:secure_random, "~> 0.5"},
      {:timex_ecto, "~> 3.2"},
      {:wallaby, "~> 0.22.0", [runtime: false, only: :test]},
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"],
    ]
  end
end
