<script lang="ts">
  let own: HTMLElement;
  let container: HTMLElement;
  let inFrame = false;

  function handleMouseEnter() {
    inFrame = true;
  }

  function handleMouseLeave() {
    inFrame = false;
  }

  function handleMouseMove(event: MouseEvent) {
    const rect = container.getBoundingClientRect();
    own.style.top = `${event.clientY - rect.top}px`;
    own.style.left = `${event.clientX - rect.left}px`;
  }
</script>

<div
  bind:this={container}
  role="presentation"
  class="relative w-full h-96 cursor-none bg-zinc-50 overflow-hidden"
  on:mouseenter={handleMouseEnter}
  on:mouseleave={handleMouseLeave}
  on:mousemove={handleMouseMove}
>
  <span
    bind:this={own}
    class="hero-arrow-up-left-mini h-5 w-5 absolute"
    class:hidden={!inFrame}
  />
</div>
