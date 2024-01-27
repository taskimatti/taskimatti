<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { navigateTo } from 'nuxt/app';
import { useProject } from '~/composables/states';
import { useDirectus } from '~/composables/directus';
import { useRoute } from 'vue-router';

const { $directus, $readItems } = useDirectus();

const route = ref(useRoute());
const uuid = ref(route.value?.params?.project?.toString());
const selectedUser = ref({});
const totalPoints = ref(0);

// Initialize Tasks with placeholder data
const Tasks = ref(
  Array(5).fill({
    id: Array(36).fill('Loading...').join(''),
    title: 'Loading task title...',
    desc: 'Loading task description, this is a placeholder description.',
    points: 0,
    status: false,
    users: [],
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
        fields: [
          'id, status, project, title, points, desc, type, image, sort, users.directus_users_id.id, users.completed, users.directus_users_id.first_name, users.directus_users_id.avatar, users.directus_users_id.role.name, users.is_admin',
        ],
      }),
    );

    // Get completed status for each task for selected user
    Tasks.value.map((task) => {
      task.completed =
        task.users.filter((user: any) => user.directus_users_id.id === route.value.params.id)[0]?.completed ?? false;
    });

    // Get selected user data
    selectedUser.value = Tasks.value[0].users.filter(
      (user: any) => user.directus_users_id.id == route.value.params.id,
    )[0];

    // Calculate total points for user on project for completed tasks
    totalPoints.value = Tasks.value.reduce((acc: any, task: any) => {
      if (task.users.filter((user: any) => user.directus_users_id.id === route.value.params.id)[0]?.completed) {
        return acc + task.points;
      } else {
        return acc;
      }
    }, 0);
  } else {
    navigateTo('/');
  }
};

onMounted(async () => {
  await updatePage();
});
</script>

<template>
  <div class="min-h-screen stext-white">
    <div class="p-5">
      <NuxtLink :to="'/'+project.value?.id + '/admin'">
        <button class="px-4 py-2 text-black bg-white rounded hover:bg-gray-200">Back</button>
      </NuxtLink>
      <div class="mt-10 flex flex-col items-center">
        <NuxtImg
            v-if="selectedUser?.directus_users_id?.avatar"
            :src="$directus.url.href + 'assets/' + selectedUser?.directus_users_id?.avatar"
            class="w-24 h-24 object-cover rounded-full"
        />
        <h1 class="mt-4 text-3xl font-semibold">{{ selectedUser?.directus_users_id?.first_name }}</h1>
        <p class="mt-2 text-lg text-gray-200">{{ selectedUser?.directus_users_id?.role.name }}</p>
        <p class="mt-1 text-lg text-gray-200">Points: {{ totalPoints }}</p>
      </div>
      <div class="mt-10">
        <h2 class="text-2xl font-semibold text-gray-200">Tasks</h2>
        <div class="mt-4 space-y-4">
          <div v-for="task in Tasks" class="">
            <AdminTaskView :task="task" :unit="project.value?.units" />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<style scoped></style>
