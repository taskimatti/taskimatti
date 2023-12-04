<script setup lang="ts">
const { $directus, $readItems } = useNuxtApp();

const route = useRoute()

const uuid = route.params.project

const { data: Tasks } = await useAsyncData(async () => {
  return $directus.request($readItems("Tasks", {
    filter: {
      project: {
        _eq: uuid
      }
    }
  }));
});


const { data: Organisation } = await useAsyncData("Organisation", () => {
  return $directus.request($readItems("Organisation"));
});
</script>


<template>
  <div>
    <ol>
      <li v-for="task in Tasks" class="p-2">
        <Task :task="task" :unit="Organisation.units" />
      </li>
    </ol>
  </div>
</template>

<style scoped></style>
