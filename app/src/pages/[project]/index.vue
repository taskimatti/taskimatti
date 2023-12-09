<script setup lang="ts">
import { ref, watch } from "vue";
import { onBeforeRouteUpdate } from "vue-router";
import { useRoute } from "vue-router";
import { navigateTo, useAsyncData, useNuxtApp } from "nuxt/app";
import { useProject } from "../../composables/states";
import { readMe } from "@directus/sdk";

const { $directus, $readItems } = useNuxtApp();
if (process.client) {
  console.log($directus)
  $directus.setToken(window.localStorage.getItem('access-token'))
  console.log($directus)
}

const { data: _user } = await useAsyncData(() => {
  return $directus.request(readMe({ fields: ["role"] }));
});

console.log(await _user)

const route = ref(useRoute());
const uuid = ref(route.value?.params?.project?.toString());
const Tasks = ref([]);
const project = ref({});

const updatePage = async () => {
  const _uuid = ref(route.value?.params?.project?.toString());
  uuid.value = _uuid.value;
  project.value = useProject();

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
  } else {
    navigateTo("/");
  }
};

onBeforeRouteUpdate(async (to, from) => {
  if (to.path !== from.path) {
    await updatePage();
  }
});

updatePage();
</script>

<template>
  <div>
    <ol>
      <li v-for="task in Tasks" class="p-2">
        <Task :task="task" :unit="project.value?.units" />
      </li>
    </ol>
  </div>
</template>

<style scoped></style>
