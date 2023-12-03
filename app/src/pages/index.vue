<script setup lang="ts">
const { $directus, $readItems } = useNuxtApp();

const { data: Tasks } = await useAsyncData("Tasks", () => {
  return $directus.request($readItems("Tasks"));
});

const { data: Organisation } = await useAsyncData("Organisation", () => {
  return $directus.request($readItems("Organisation"));
});
</script>

<template>
  <div>
    <ol>
      <li v-for="task in Tasks">
        <Task :task="task" :unit="Organisation.units" />
      </li>
    </ol>
  </div>
</template>

<style scoped></style>
