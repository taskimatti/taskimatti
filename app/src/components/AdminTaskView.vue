<script setup lang="ts">
import { CheckIcon } from '@heroicons/vue/20/solid';
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
    <div class="text-blue-900 shadow-lg">
        <div class="rounded px-2 bg-gray-200 grid grid-cols-4 gap-4 items-center">
            <h2 class="col-start-1 text-xs ">{{ task.title }}</h2>
            <p class="col-span-2 text-xs flex">{{ task.desc }}</p>
            <CheckIcon v-if="task?.status" class="col-start-4 h-6 w-6 text-green-500 ml-auto" />
        </div>
    </div>
</template>
<style scoped></style>
