<script>
  export let connected;
  let tadas = 0;
</script>

<div class="bg-zinc-50 p-8 text-sm">
  I was rendered on the {connected ? "client" : "server"}.
  <button on:click={() => tadas++}>Celebrate</button>
  {#each [...new Array(tadas)] as _}
    🎉
  {/each}
</div>
