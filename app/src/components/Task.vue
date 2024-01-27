<script setup lang="ts">
import { CheckIcon } from '@heroicons/vue/20/solid';
import {complete} from "~/composables/tasks";

// handle btn click
const markCompleted = async (task: Task) => {
  task!.completed = !task!.completed
  await complete(task.id!);
};
</script>

<script lang="ts">
import { useAssets } from '~/composables/states';

const assets = ref(useAssets());
export default {
  props: {
    task: {
      type: Object as () => Task,
    },
    unit: {
      type: String,
      default: 'bits',
    },
  },
};
</script>

<template>
  <div
    class="text-white p-6 rounded-lg shadow-lg w-full"
    :class="task!.completed ? 'bg-green-800' : 'bg-gray-800'"
    @click="markCompleted(task!)"
  >
    <NuxtImg
      v-if="task?.image"
      :src="assets + task.image"
      alt="Task Image"
      class="w-full h-64 object-cover mb-4 rounded"
    />
    <h2 class="text-2xl mb-2">{{ task.title }}</h2>
    <p class="mb-2">{{ task.desc }}</p>
    <div class="flex items-center justify-between">
      <div class="flex items-center">
        <CheckIcon v-if="task?.completed" class="h-6 w-6 text-green-500 mr-2" />
        <span>{{ task.points }} {{ unit }}</span>
      </div>
    </div>
  </div>
</template>

<style scoped></style>
