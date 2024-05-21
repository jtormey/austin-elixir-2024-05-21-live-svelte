<script lang="ts">
  import { Live } from "live_svelte";
  import { onMount } from "svelte";
  import Button from "./CoreComponents/Button.svelte";

  type Point = [number, number, string];

  export let live: Live;
  export let path: Array<Point>;

  let own: HTMLElement;
  let container: HTMLElement;
  let canvas: HTMLCanvasElement;
  let inFrame = false;
  let drawing = false;
  let inputDelay = false;

  let color = "#000000";

  onMount(() => {
    live.handleEvent("add_point", (data) => {
      drawPoint(canvas.getContext("2d"), data.point);
    });

    live.handleEvent("clear_canvas", (data) => {
      clearCanvas(canvas.getContext("2d"));
    });

    requestAnimationFrame(() => {
      const ctx = canvas.getContext("2d");

      for (let i = 0; i < path.length; i++) {
        drawPoint(ctx, path[i]);
      }
    });
  });

  function withDelay(f: () => any) {
    setTimeout(f, inputDelay ? 1000 : 0);
  }

  function handleMouseEnter() {
    inFrame = true;
  }

  function handleMouseLeave() {
    inFrame = false;
  }

  function handleMouseDown() {
    drawing = true;
  }

  function handleMouseUp() {
    drawing = false;
  }

  function handleMouseMove(event: MouseEvent) {
    const rect = container.getBoundingClientRect();

    const x = event.clientX - rect.left;
    const y = event.clientY - rect.top;

    own.style.left = `${x}px`;
    own.style.top = `${y}px`;

    if (drawing) {
      const p: Point = [x, y, color];

      drawPoint(canvas.getContext("2d"), p);
      withDelay(() => live.pushEvent("add_point", p));
    }
  }

  function handleClickClearCanvas() {
    clearCanvas(canvas.getContext("2d"));
    withDelay(() => live.pushEvent("clear_canvas"));
  }

  function drawPoint(ctx: CanvasRenderingContext2D, point: Point) {
    ctx.fillStyle = point[2];
    ctx.fillRect(point[0], point[1], 1, 1);
  }

  function clearCanvas(ctx: CanvasRenderingContext2D) {
    ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
  }
</script>

<div class="mb-4 flex gap-2">
  <Button on:click={() => (inputDelay = !inputDelay)}>
    Turn input delay {inputDelay ? "off" : "on"}
  </Button>
  <Button on:click={handleClickClearCanvas}>Clear</Button>
</div>

<div
  bind:this={container}
  role="presentation"
  class="relative w-full h-96 cursor-none bg-zinc-50 overflow-hidden"
  on:mouseenter={handleMouseEnter}
  on:mouseleave={handleMouseLeave}
  on:mousedown={handleMouseDown}
  on:mouseup={handleMouseUp}
  on:mousemove={handleMouseMove}
>
  <canvas
    bind:this={canvas}
    width={container?.getBoundingClientRect().width}
    height={container?.getBoundingClientRect().height}
  />
  <span
    bind:this={own}
    class="hero-arrow-up-left h-5 w-5 absolute"
    class:hidden={!inFrame}
  />
</div>
