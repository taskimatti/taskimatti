<script setup lang="ts">
import { ref } from "vue";
import { useAssets, useProjects } from "~/composables/states";

const projects = ref({});
const assets = ref({});

const updatePage = async () => {
  projects.value = useProjects();
  assets.value = useAssets();
  //
};

await updatePage();
</script>

<template>
  <div class="flex flex-col justify-center items-center min-h-[80vh]">
    <h1 class="text-3xl p-4">Select project</h1>
    <ol>
      <li class="m-6" v-for="project in projects.value" :key="project.id">
        <NuxtLink :to="project.id">
          <div class="rounded-lg shadow-lg overflow-hidden" :style="'background: ' + project.colorScheme">
            <NuxtImg
              :src="assets.value + project.image"
              class="w-full h-32 object-cover"
              width="384"
              height="128"
              quality="10"
              placeholder="/images/placeholder.svg"
            />
            <div class="p-6">
              <h2 class="text-2xl font-bold mb-2">{{ project.name }}</h2>
              <p class="text-gray-300">{{ project.description }}</p>
            </div>
          </div>
        </NuxtLink>
      </li>
    </ol>
  </div>
</template>

<style scoped></style>
