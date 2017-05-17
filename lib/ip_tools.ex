defmodule IpTools do
  @moduledoc """
    Simple set of tools for finding the host machine's IP and a HTTP wrapper
    around ipinfo.
  """

  @doc """
    Uses `System.cmd` to call dig with the short modifier, calling "myip.opendns.com"
  """
  def get_ip do
    {ip, _} = System.cmd("dig", ["+short", "myip.opendns.com", "@resolver1.opendns.com"])
    ip |> String.strip
  end

  @doc """
    Calls ipinfo.io with a provided ip address and returns a rough Lat Lon pair
  """
  def get_ip_lat_lon(ip) do
    ip
    |> _build_url
    |> HTTPoison.get
    |> clean_lat_lon_string
  end

  defp _build_url(ip) do
    "ipinfo.io/#{ip}/loc"
  end

  defp clean_lat_lon_string({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    body
    |> String.strip
    |> String.split(",")
    |> Enum.map(fn x -> String.to_float(x) end)
  end

  defp clean_lat_lon_string({:ok, %HTTPoison.Response{status_code: 404}}) do
    IO.puts "Could not get a lat and lon for your ip"
    System.halt(2)
  end

  defp clean_lat_lon_string({:error, %HTTPoison.Error{reason: reason}}) do
    IO.inspect(reason)
    System.halt(2)
  end
end
