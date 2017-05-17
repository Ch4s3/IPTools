defmodule IpTools.Mixfile do
  use Mix.Project

  def project do
    [app: :ip_tools,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [{:httpoison, "~> 0.11.1"}]
  end

  defp description do
    """
    A simple set of ip related tools focused on geolocation.
    """
  end

  defp package do
    [# These are the default files included in the package
     name: :ip_tools,
     maintainers: ["Chase Gilliam"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/Ch4s3/IPTools"}]
  end
end
