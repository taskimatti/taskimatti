<script setup lang="ts">
import { ref, watch } from "vue";
import { useAssets, useProject } from "../../composables/states";

const project = ref({});
const assets = ref({});
const updatePage = async () => {
  project.value = useProject();
  assets.value = useAssets();
};

await updatePage();

watch(
  () => project.value,
  async (newProject) => {
    project.value = newProject;
    await updatePage();
  },
);
</script>

<template>
  <div v-if="project.value.id">
    <div
      class="flex flex-row items-center justify-between p-2 h-16"
      :style="'background: ' + project.value.colorScheme + ';'"
    >
      <NuxtImg
        :src="assets.value + project.value.image"
        class="w-12 h-12 rounded-full object-cover"
        width="64"
        height="64"
        quality="10"
        placeholder
      />
      <div class="flex">
        <h1 class="text-3xl text-white">{{ project.value.name }}</h1>
        <dev-only><p class="text-green-700">DEV</p></dev-only>
      </div>
      <p>{{ 12 }} {{ project.value.units }}</p>
    </div>
  </div>
</template>

<style scoped></style>
