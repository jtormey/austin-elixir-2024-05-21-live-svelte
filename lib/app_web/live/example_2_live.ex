defmodule AppWeb.Example2Live do
  use AppWeb, :live_view

  def render(assigns) do
    ~H"""
    <.header class="mb-10">
      Example 2
      <:subtitle>Figma Cursor</:subtitle>
    </.header>

    <.svelte name="Example2" props={%{}} socket={@socket} />
    """
  end
end
