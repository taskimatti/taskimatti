<script setup lang="ts">
import { ref, watch } from "vue";
import { useRoute } from "vue-router";

const { $directus, $readItems } = useNuxtApp();

const route = useRoute();

let uuid = ref(route.params.project); // make uuid a reactive ref
// client only
if (process.client) {
  uuid.value = localStorage.getItem("project-uuid"); // get the uuid from local storage
}

let Tasks = ref([]); // make Tasks a reactive ref
let Organisation = ref({}); // make Organisation a reactive ref

// define a function to fetch the data based on the uuid
const fetchData = async () => {
  Tasks.value = await $directus.request(
    $readItems("Tasks", {
      filter: {
        project: {
          _eq: uuid.value,
        },
      },
    }),
  );

  Organisation.value = await $directus.request($readItems("Organisation"));
};

// call the function initially
fetchData();

// watch for changes in the route params and update the uuid and data
watch(
  () => route.params.project,
  (newUuid) => {
    uuid.value = newUuid;
    fetchData();
  },
);
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
