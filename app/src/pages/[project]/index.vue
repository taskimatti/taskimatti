<script setup lang="ts">
import {onMounted, ref} from "vue";
import {useRoute} from "vue-router";
import {navigateTo} from "nuxt/app";
import {useProject} from "~/composables/states";
import {useDirectus} from "~/composables/directus";

const { $directus, $readItems } = useDirectus();

const route = ref(useRoute());
const uuid = ref(route.value?.params?.project?.toString());

// Initialize Tasks with placeholder data
const Tasks = ref(Array(5).fill({
  id: Array(36).fill("Loading...").join(""),
  title: "Loading task title...",
  desc: "Loading task description, this is a placeholder description.",
  points: 0,
  status: false,
}));

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

onMounted(async () => {
  await updatePage();
});
</script>

<template>
  <div>
    <ol>
      <li v-for="task in Tasks" class="p-2 w-auto">
        <Task :task="task" :unit="project.value?.units" />
      </li>
    </ol>
  </div>
</template>

<style scoped></style>