<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { useRoute } from 'vue-router';
import { navigateTo } from 'nuxt/app';
import { useProject, useUser } from '~/composables/states';
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

  const user_id = useUser().value.id;
  if (uuid.value?.toString().length === 36) {
    Tasks.value = await $directus.request(
      $readItems('Tasks', {
        filter: {
          project: {
            _eq: uuid.value,
          },
          // users: {
          //   directus_users_id: {
          //     id: {
          //       _eq: user_id,
          //     },
          //   },
          // },
          status: {
            _eq: 'published',
          },
        },
        fields: ['id, status, project, title, points, desc, type, image, sort, users.*.*.*'],
      }),
    );
    Tasks.value.map((task) => {
      task.completed = task.users.filter((user: any) => user.directus_users_id.id === user_id)[0]?.completed ?? false;
    });
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
    <ol>
      <li v-for="task in Tasks" class="p-2 w-auto">
        <Task :task="task" :unit="project.value?.units" />
      </li>
    </ol>
  </div>
</template>

<style scoped></style>
