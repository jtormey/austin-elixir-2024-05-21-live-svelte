defmodule App.CanvasServer do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def draw(p) do
    GenServer.cast(__MODULE__, {:draw, self(), p})
  end

  def get_canvas() do
    GenServer.call(__MODULE__, :get_canvas)
  end

  def clear_canvas() do
    GenServer.call(__MODULE__, :clear_canvas)
  end

  def subscribe() do
    Phoenix.PubSub.subscribe(App.PubSub, "canvas")
  end

  ## Callbacks

  def init(opts) do
    canvas_size = opts[:canvas_size] || {100, 100}
    {:ok, %{canvas: [], canvas_size: canvas_size}}
  end

  def handle_cast({:draw, pid, p}, state) do
    if point_within_canvas(p, state.canvas_size) do
      Phoenix.PubSub.broadcast(App.PubSub, "canvas", {:canvas_op, pid, :add_point, p})
      {:noreply, Map.update!(state, :canvas, &[p | &1])}
    else
      {:noreply, state}
    end
  end

  def handle_call(:get_canvas, _from, state) do
    {:reply, Enum.reverse(state.canvas), state}
  end

  def handle_call(:clear_canvas, {pid, _ref}, state) do
    Phoenix.PubSub.broadcast(App.PubSub, "canvas", {:canvas_op, pid, :clear_canvas})
    {:reply, :ok, %{state | canvas: []}}
  end

  ## Private

  def point_within_canvas([px, py, _color], {w, h}) do
    0 <= px and px <= w and 0 <= py and py <= h
  end
end
