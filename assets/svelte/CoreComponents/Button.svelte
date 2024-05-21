<script lang="ts">
  export let type: "button" | "submit" | "reset" = "button";
  export let className: string | null = null;
</script>

<button
  {type}
  class={[
    "phx-submit-loading:opacity-75 rounded-lg bg-zinc-900 hover:bg-zinc-700 py-2 px-3",
    "text-sm font-semibold leading-6 text-white active:text-white/80",
    className,
  ].join(" ")}
  on:click
>
  <slot />
</button>
