<script setup lang="ts">
import { CheckIcon, XMarkIcon} from '@heroicons/vue/20/solid';
import { useDirectus } from '~/composables/directus';
const { $directus } = useDirectus();
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
  <div class="bg-white shadow rounded-lg p-6 my-4 flex flex-col">
    <div class="flex items-center space-x-4">
      <NuxtImg :src="assets + task?.image" class="w-16 h-16 object-cover rounded-full" />
      <div>
        <h2 class="text-xl font-semibold text-gray-900">{{ task?.title }}</h2>
        <p class="mt-2 text-gray-600">{{ task?.desc }}</p>
      </div>
    </div>
    <div class="mt-4 self-end flex items-center">
      <CheckIcon v-if="task?.completed" class="h-6 w-6 text-green-500" />
      <p v-if="task?.completed" class="ml-2 text-green-500">Completed</p>
      <XMarkIcon v-else class="h-6 w-6 text-red-500" />
      <p v-else class="ml-2 text-red-500">Not Completed</p>
    </div>
  </div>
</template>

<style scoped></style>
