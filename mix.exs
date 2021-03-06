defmodule Stardust.Mixfile do
  use Mix.Project

  def project do
    [app: :stardust,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: [
      "coveralls": :test,
      "coveralls.detail": :test,
      "coveralls.post": :test,
      "coveralls.html": :test,
     ],
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      { :earmark, "~> 1.2.2" },
      { :ex_doc, "~> 0.14" },
      { :excheck, "~> 0.5", only: :test },
      { :excoveralls, "~> 0.6", only: :test },
      { :credo, "~> 0.8.0-rc7", only: [:dev, :test], runtime: false },
      { :triq, github: "triqng/triq", only: :test },
    ]
  end
end
