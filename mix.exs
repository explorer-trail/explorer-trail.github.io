defmodule ExplorerTrail.MixProject do
  use Mix.Project

  def project do
    [
      app: :explorer_trail,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp aliases() do
    [
      "site.build": ["build", "tailwind default --minify", "esbuild default --minify"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nimble_publisher, "~> 1.0"},
      {:makeup_elixir, ">= 0.0.0"},
      {:makeup_erlang, ">= 0.0.0"},
      {:phoenix_live_view, "~> 1.0.0-rc.0"},
      {:esbuild, "~> 0.8"},
      {:tailwind, "~> 0.2"}
    ]
  end
end
