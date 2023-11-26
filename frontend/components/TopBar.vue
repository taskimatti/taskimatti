<script setup lang="ts"></script>
<script lang="ts">
export default {
  props: {
    score: {
      type: Number,
    },
  },
};
</script>

<template>
  <div class="fixed top-0 bg-slate-900 w-screen">
    <div class="flex items-center justify-center p-2">
      <div class="flex">
        <h1 class="text-center text-3xl text-white">Fuksipassi</h1>
        <dev-only><p class="text-green-700">DEV</p></dev-only>
      </div>
    </div>
    <p class="fixed top-0 right-0 pt-3 pr-6">{{ score }} bits</p>
  </div>
</template>

<style scoped></style>
