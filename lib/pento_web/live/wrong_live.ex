defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    {
      :ok,
      assign(
        socket,
        score: 0,
        message: "Guess a number",
        number: Enum.random(0..10),
        win: false
      )
    }
  end

  def render(assigns) do
    ~L"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
      It's <%= @number %>
    </h2>
    <%= if @win do %>
      <h2>
        win
        <%= live_patch "New game", to: "/guess", replace: true %>
      </h2>
    <% else %>
      <h2>
        <%= for n <- 1..10 do %>
          <a herf="#" phx-click="guess" phx-value-number="<%= n %>"><%= n %></a>
        <% end %>
      </h2>
    <% end %>
    """
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    %{assigns: %{number: number, score: score}} = socket

    if String.to_integer(guess) == number do
      message = "You win, it's #{number}."

      {
        :noreply,
        assign(
          socket,
          message: "You win, it's #{number}. ",
          score: score + 2,
          win: true
        )
      }
    else
      {
        :noreply,
        assign(
          socket,
          message: "Your guess: #{guess}. Wrong. Guess again. ",
          score: score - 1,
          win: false
        )
      }
    end
  end

  def handle_params(_params, _uri, socket) do
    {
      :noreply,
      assign(
        socket,
        score: 0,
        message: "Guess a number",
        number: Enum.random(0..10),
        win: false
      )
    }
  end

  def time() do
    DateTime.utc_now() |> to_string()
  end
end
