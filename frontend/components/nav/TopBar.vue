<script setup lang="ts">
import {inject} from 'vue';

const org = inject('organisation');
const tasks = inject('tasks');
const name = org.name;
const units = org.units;
const colorScheme = org.colorscheme;

const score = tasks.reduce((acc, task) => {
  if (task.status) {
    return acc + task.points;
  } else {
    return acc;
  }
}, 0);
</script>


<template>
  <div :class="['fixed top-0 bg-' + colorScheme + ' w-screen']">
    <div class="flex items-center justify-center p-2">
      <div class="flex">
        <h1 class="text-center text-3xl text-white">{{ name }}</h1>
        <dev-only><p class="text-green-700">DEV</p></dev-only>
      </div>
    </div>
    <p class="fixed top-0 right-0 pt-3 pr-6">{{ score }} {{ units }}</p>
  </div>
</template>

<style scoped></style>
