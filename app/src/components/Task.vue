<script setup lang="ts">
import { CheckIcon } from '@heroicons/vue/20/solid';
</script>

<script lang="ts">
export default {
  props: {
    task: {
      type: Object as () => DefaultTask,
    },
    unit: {
      type: String,
      default: 'bits',
    },
  },
};
</script>

<template>
  <div class="bg-gray-800 text-white p-6 rounded-lg shadow-lg w-full">
    <NuxtImg
      v-if="task.image"
      :src="$directus.url.href + 'assets/' + task.image"
      alt="Task Image"
      class="w-full h-64 object-cover mb-4 rounded"
    />
    <h2 class="text-2xl mb-2">{{ task.title }}</h2>
    <p class="mb-2">{{ task.desc }}</p>
    <div class="flex items-center justify-between">
      <div class="flex items-center">
        <CheckIcon v-if="task.status" class="h-6 w-6 text-green-500 mr-2" />
        <span>{{ task.points }} {{ unit }}</span>
      </div>
    </div>
  </div>
</template>

<style scoped></style>
