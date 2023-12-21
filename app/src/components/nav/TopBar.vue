<script setup lang="ts">
import { type Ref, ref, watch } from 'vue';
import { useAssets, useProject } from '~/composables/states';

const project: Ref<Project | null> = ref(null);
const assets: Ref<String | null> = ref('');
const updatePage = async () => {
  project.value = useProject().value;
  assets.value = useAssets().value;
};

await updatePage();

watch(
  () => useProject().value,
  async () => {
    await updatePage();
  },
);
</script>

<template>
  <div v-if="project?.id">
    <div
      class="fixed w-full max-w-lg flex flex-row items-center justify-between p-2 h-16"
      :style="'background: ' + project?.colorScheme + ';'"
    >
      <NuxtLink :to="'/'">
        <NuxtImg
          :src="assets + project?.image"
          class="w-12 h-12 object-cover rounded-full"
          width="48"
          height="48"
          quality="10"
          placeholder="/images/placeholder.svg"
        />
      </NuxtLink>
      <div class="flex">
        <h1 class="text-3xl text-white">{{ project?.name }}</h1>
        <dev-only><p class="text-green-700">DEV</p></dev-only>
      </div>
      <p>
        {{ new Date().getMilliseconds().toString().slice(0, 2) }}
        {{ project?.units }}
      </p>
    </div>
  </div>
</template>

<style scoped></style>
