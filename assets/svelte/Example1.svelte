<script lang="ts">
  import { Live } from "live_svelte";
  import Button from "./CoreComponents/Button.svelte";

  export let number: number;
  export let live: Live;

  let local: number = 0;
</script>

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
