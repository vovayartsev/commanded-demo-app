defmodule Benchmark.Festivals do
  alias __MODULE__.Commands.{CreateFestival, BookTicket}

  def create_festival(tickets_count) do
    uuid = UUID.uuid4()

    %CreateFestival{
      festival_uuid: uuid,
      initial_tickets_count: tickets_count
    }
    |> Benchmark.Router.dispatch(consistency: :eventual)
  end

  def book_ticket(festival_uuid, username) do
    %BookTicket{
      festival_uuid: festival_uuid,
      username: username
    }
    |> Benchmark.Router.dispatch()
  end

end
