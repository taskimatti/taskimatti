<script setup lang="ts">
import data from "../../data/tasks.json";
import type DefaultTask from "../../types";
const tasks: DefaultTask[] = data.data;
let score;
// calculate sum of scores where status is true
score = tasks
  .filter((task) => task.status)
  .map((task) => task.points)
  .reduce((a, b) => a + b, 0);
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
