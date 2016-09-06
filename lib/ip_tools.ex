defmodule IpTools do
  def get_ip() do
    {ip, _} = System.cmd("dig",["+short", "myip.opendns.com", "@resolver1.opendns.com"])
    ip |> String.strip
  end

  def get_ip_lat_lon(ip) do
    HTTPoison.start
    url = "ipinfo.io/" <> ip <> "/loc"
    res = HTTPoison.get url

    res
      |> clean_lat_lon_string
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
