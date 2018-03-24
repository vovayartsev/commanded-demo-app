defmodule Benchmark.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Benchmark.Repo, []),
      # Start the endpoint when the application starts
      supervisor(BenchmarkWeb.Endpoint, []),
      # Start your own worker by calling: Benchmark.Worker.start_link(arg1, arg2, arg3)
      # worker(Benchmark.Worker, [arg1, arg2, arg3]),
      supervisor(Benchmark.Festivals.Supervisor, [])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Benchmark.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BenchmarkWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
