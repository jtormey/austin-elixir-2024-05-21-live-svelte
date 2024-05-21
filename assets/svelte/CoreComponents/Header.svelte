<script lang="ts">
  export let className: string;
</script>

<header class={`flex items-center justify-between gap-6 ${className}`}>
  <div>
    <h1 class="text-lg font-semibold leading-8 text-zinc-800">
      <slot />
    </h1>
    {#if $$slots.subtitle}
      <p class="mt-2 text-sm leading-6 text-zinc-600">
        <slot name="subtitle" />
      </p>
    {/if}
  </div>
  <div class="flex-none"><slot name="actions" /></div>
</header>
