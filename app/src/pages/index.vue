<script setup lang="ts">
const { $directus, $readItems } = useNuxtApp();

const { data: project } = await useAsyncData(() => {
  return $directus.request($readItems("Project"));
});


</script>

<template>
  <div>
    <h1>Select organisation</h1>
    <div v-for="project in project">
      <NuxtLink class="underline text-blue-500" :to=project.id>{{project.name}}</NuxtLink>
    </div>
  </div>
</template>

<style scoped></style>
