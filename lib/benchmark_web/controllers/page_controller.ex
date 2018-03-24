defmodule BenchmarkWeb.PageController do
  use BenchmarkWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def book(conn, %{"uuid" => uuid}) do
    case Benchmark.Festivals.book_ticket(uuid, UUID.uuid4()) do
    # case :ok do
      :ok -> send_resp(conn, 200, "OK")
      {:error, reason} -> send_resp(conn, 401, reason)
    end
  end
end
