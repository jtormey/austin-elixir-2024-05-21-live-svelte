defmodule AppWeb.Example3Live do
  use AppWeb, :live_view

  def render(assigns) do
    ~H"""
    <.header class="mb-10">
      Example 3
      <:subtitle>Server Rendering.</:subtitle>
    </.header>

    <div class="mb-4 flex gap-2">
      <.link_button href={~p"/examples/3"}>No delay</.link_button>
      <.link_button href={~p"/examples/3?delay=1000"}>Delay 1s</.link_button>
      <.link_button href={~p"/examples/3?delay=3000"}>Delay 3s</.link_button>
      <.link_button href={~p"/examples/3?delay=5000"}>Delay 5s</.link_button>
    </div>

    <.svelte name="Example3" props={%{connected: @connected}} socket={@socket} />
    """
  end

  def mount(params, _session, socket) do
    if connected?(socket) do
      if delay = params["delay"] do
        Process.sleep(String.to_integer(delay))
      end
    end

    {:ok, assign(socket, :connected, connected?(socket))}
  end

  attr :rest, :global, include: ~w(href navigate)
  slot :inner_block, required: true

  def link_button(assigns) do
    ~H"""
    <.link class="text-xs font-bold rounded-lg bg-zinc-100 px-2 py-1 hover:bg-zinc-200/80" {@rest}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end
end
