<script setup lang="ts">
import { ref, watch } from "vue";
import { onBeforeRouteUpdate } from "vue-router";
import { useRoute } from "vue-router";
import { navigateTo } from "nuxt/app";

const { $directus, $readItems } = useNuxtApp();

const route = ref(useRoute());
const uuid = ref(route.value?.params?.project?.toString());
const Tasks = ref([]);
const Organisation = ref({});

const updatePage = async () => {
  const _uuid = ref(route.value?.params?.project?.toString());
  uuid.value = _uuid.value;

  if (uuid.value?.toString().length === 36) {
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
  } else {
    navigateTo("/");
  }
};

console.log("INITIALIZING");
await updatePage();

onBeforeRouteUpdate(async (to, from) => {
  if (to.path !== from.path) {
    await updatePage();
  }
});

watch(
  () => route.value,
  async () => {
    await updatePage();
  },
);

watch(
  () => uuid.value,
  async (newUuid) => {
    uuid.value = newUuid;
    console.log("UPDATING");
    await updatePage();
  },
);

watch(
  () => Tasks.value,
  async (newTasks) => {
    Tasks.value = newTasks;
    console.log("UPDATING");
    await updatePage();
  },
);

watch(
  () => Organisation.value,
  async (newOrganisation) => {
    Organisation.value = newOrganisation;
    console.log("UPDATING");
    await updatePage();
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
