defmodule Benchmark.Festivals.Aggregates.Festival do
  defstruct festival_uuid: nil,
            remaining_tickets: 0

  alias Benchmark.Festivals.Aggregates.Festival
  alias Benchmark.Festivals.Commands.{CreateFestival, BookTicket}
  alias Benchmark.Festivals.Events.{FestivalCreated, TicketBooked}

  def execute(%Festival{festival_uuid: nil}, %CreateFestival{
        festival_uuid: uuid,
        initial_tickets_count: cnt
      }) do
    %FestivalCreated{
      festival_uuid: uuid,
      initial_tickets_count: cnt
    }
  end

  def execute(%Festival{festival_uuid: uuid, remaining_tickets: remaining_tickets}, %BookTicket{
        username: username
      })
      when is_binary(uuid) do
    if remaining_tickets > 0 do
      %TicketBooked{
        festival_uuid: uuid,
        username: username
      }
    else
      {:error, "No more tickets left"}
    end
  end

  def execute(_, command) do
    {:error, "Unknown command or invalid state: #{inspect(command)}"}
  end

  def apply(_, %FestivalCreated{festival_uuid: uuid, initial_tickets_count: cnt}) do
    %Festival{festival_uuid: uuid, remaining_tickets: cnt}
  end

  def apply(festival, %TicketBooked{}) do
    Map.update!(festival, :remaining_tickets, fn cnt -> cnt - 1 end)
  end
end
