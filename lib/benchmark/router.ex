defmodule Benchmark.Router do
  use Commanded.Commands.Router

  alias Benchmark.Festivals.Aggregates.Festival
  alias Benchmark.Festivals.Commands.{CreateFestival, BookTicket}

  identify(Festival, by: :festival_uuid, prefix: "festival-")

  dispatch([CreateFestival, BookTicket], to: Festival)
end
