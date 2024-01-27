<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { useRoute } from 'vue-router';
import { navigateTo } from 'nuxt/app';
import { useProject } from '~/composables/states';
import { useDirectus } from '~/composables/directus';

const { $directus, $readItems } = useDirectus();

const route = ref(useRoute());
const uuid = ref(route.value?.params?.project?.toString());

// Initialize Tasks with placeholder data
const Tasks = ref(
  Array(5).fill({
    id: Array(36).fill('Loading...').join(''),
    title: 'Loading task title...',
    desc: 'Loading task description, this is a placeholder description.',
    points: 0,
    status: false,
  }),
);

const project = ref({});

const updatePage = async () => {
  const _uuid = ref(route.value?.params?.project?.toString());
  uuid.value = _uuid.value;
  project.value = useProject();

  if (uuid.value?.toString().length === 36) {
    Tasks.value = await $directus.request(
      $readItems('Tasks', {
        filter: {
          project: {
            _eq: uuid.value,
          },
        },
      }),
    );
  } else {
    navigateTo('/');
  }
};

onMounted(async () => {
  await updatePage();
});
</script>

<template>
  <div>
    <div class=" text-blue-900 rounded shadow-lg py-2">
      <div class="rounded px-2 bg-gray-200 grid grid-cols-4 items-center">
      <h2 class="col-start-1 text-xl">Title </h2>
        <p class="col-start-2 text-xl">Description</p>
        <p class="col-start-4 ml-auto text-xl ">Status</p>
      </div>
    </div>  
    <ol>
      <li v-for="task in Tasks" class="py-1 w-auto">
        <AdminTaskView :task="task" :unit="project.value?.units" />
      </li>
    </ol>
  </div>
</template>

<style scoped></style>