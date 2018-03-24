defmodule Benchmark.Festivals.Supervisor do
  use Supervisor

  # alias Benchmark.Festivals.Projectors
  # alias Benchmark.Festivals.Workflows

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init([

    ], strategy: :one_for_one)
  end
end
