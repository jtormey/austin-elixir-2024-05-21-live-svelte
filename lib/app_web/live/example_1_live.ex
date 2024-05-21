defmodule AppWeb.Example1Live do
  use AppWeb, :live_view

  def render(assigns) do
    ~H"""
    <.header class="mb-10">
      Example 1
      <:subtitle>Local & Remote Counters</:subtitle>
    </.header>

    <.svelte name="Example1" props={%{number: @number}} socket={@socket} />
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :number, 0)}
  end

  def handle_event("inc", _params, socket) do
    {:noreply, update(socket, :number, &(&1 + 1))}
  end

  def handle_event("dec", _params, socket) do
    {:noreply, update(socket, :number, &(&1 - 1))}
  end
end
