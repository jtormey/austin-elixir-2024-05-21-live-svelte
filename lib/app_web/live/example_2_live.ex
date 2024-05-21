defmodule AppWeb.Example2Live do
  use AppWeb, :live_view

  def render(assigns) do
    ~V"""
    <script lang="ts">
      import { Live } from "live_svelte";
      import Button from "../../../assets/svelte/CoreComponents/Button.svelte";
      import Header from "../../../assets/svelte/CoreComponents/Header.svelte";

      export let number: number;
      export let live: Live;

      let local: number = 0;
    </script>

    <Header className="mb-10">
      Example 2
      <span slot="subtitle">Write Svelte in LiveView.</span>
    </Header>

    <div class="space-y-4">
      <div>
        Local count is: {local}
      </div>

      <div>
        <Button on:click={() => local++}>Increment</Button>
        <Button on:click={() => local--}>Decrement</Button>
      </div>

      <div>
        Remote count is: {number}
      </div>

      <div>
        <Button on:click={() => live.pushEvent("inc")}>Increment</Button>
        <Button on:click={() => live.pushEvent("dec")}>Decrement</Button>
      </div>
    </div>
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
