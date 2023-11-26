<script lang="ts">
import type DefaultTask from "~/types";

export default {
  props: {
    task: {
      type: Object as () => DefaultTask,
    },
  },
};
</script>

<template>
  <div class="p-4 bg-gray-900">
    <div class="p-6 rounded-lg shadow-lg bg-gray-800 text-white mb-4">
      <h2 class="text-2xl font-bold mb-2">{{ task.name }}</h2>
      <div class="flex flex-col sm:flex-row items-center">
        <input
            v-if="task?.status"
            class="mr-2 h-5 w-5 text-indigo-400 rounded"
            type="checkbox"
            :id="task?.id"
            checked
        />
        <input
            v-if="!task?.status"
            class="mr-2 h-5 w-5 text-indigo-400 rounded"
            type="checkbox"
            :id="task?.id"
        />
        <p class="text-gray-300">{{ task.desc }}</p>
        <span
            class="mt-2 sm:mt-0 sm:ml-3 text-sm bg-indigo-700 text-indigo-100 px-2 py-1 rounded-full"
        >{{ task.points }} bits</span
        >
      </div>
    </div>
    <!-- Repeat the above div for each task in the list -->
  </div>
</template>


<style scoped></style>
