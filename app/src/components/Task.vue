<script lang="ts">
import type DefaultTask from "../types";

export default {
  props: {
    task: {
      type: Object as () => DefaultTask,
    },
  },
};
</script>

<template>
  <div class="p-2">
    <div v-if="task?.status" class="p-6 rounded-lg shadow-lg bg-gray-800 text-white mb-4">
      <h2 class="text-2xl font-bold mb-4">{{ task.name }}</h2>
      <div class="flex items-center">
        <input class="mr-2 h-5 w-5 text-green-400 rounded" type="checkbox" :id="task?.id" disabled checked />
        <p class="text-gray-300">{{ task.desc }}</p>
        <span class="whitespace-nowrap ml-auto text-sm bg-green-700 text-green-100 px-2 py-1 rounded-full"
          >{{ task.points }} bits</span
        >
      </div>
    </div>
    <div v-if="!task?.status" class="p-6 rounded-lg shadow-lg bg-gray-800 text-white mb-4">
      <h2 class="text-2xl font-bold mb-4">{{ task.name }}</h2>
      <div class="flex items-center">
        <input class="mr-2 h-5 w-5 text-indigo-400 rounded" type="checkbox" :id="task?.id" disabled />
        <p class="text-gray-300">{{ task.desc }}</p>
        <span class="whitespace-nowrap ml-auto text-sm bg-indigo-700 text-indigo-100 px-2 py-1 rounded-full"
          >{{ task.points }} bits</span
        >
      </div>
    </div>
    <!-- Repeat the above div for each task in the list -->
  </div>
</template>

<style scoped></style>
