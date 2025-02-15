defmodule AppWeb.Example4Live do
  use AppWeb, :live_view

  alias App.CanvasServer

  def render(assigns) do
    ~H"""
    <.header class="mb-10">
      Example 4
      <:subtitle>Relaying Client Events.</:subtitle>
    </.header>

    <.svelte name="Example4" props={%{path: @path}} socket={@socket} />
    """
  end

  def mount(_params, _session, socket) do
    if connected?(socket) do
      CanvasServer.subscribe()
    end

    {:ok, assign(socket, :path, CanvasServer.get_canvas())}
  end

  def handle_event("add_point", point, socket) do
    CanvasServer.draw(point)
    {:noreply, socket}
  end

  def handle_event("clear_canvas", _params, socket) do
    CanvasServer.clear_canvas()
    {:noreply, socket}
  end

  def handle_info({:canvas_op, pid, :add_point, point}, socket) do
    if pid == self() do
      {:noreply, socket}
    else
      {:noreply, push_event(socket, "add_point", %{point: point})}
    end
  end

  def handle_info({:canvas_op, pid, :clear_canvas}, socket) do
    if pid == self() do
      {:noreply, socket}
    else
      {:noreply, push_event(socket, "clear_canvas", %{})}
    end
  end
end
