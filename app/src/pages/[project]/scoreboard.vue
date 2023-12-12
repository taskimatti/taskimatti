<script setup lang="ts">
import { ref, onMounted } from "vue";
import { readUsers } from "@directus/sdk";
import { useProject } from "~/composables/states";
import { useDirectus } from "~/composables/directus";

const { $directus } = useDirectus();

// Initialize users with placeholder data
const users = ref(
  Array(10).fill({
    id: "Loading...",
    first_name: "Loading...",
    avatar: "placeholder.jpg",
    role: "Loading...",
    score: 0,
    rank: 0,
  }),
);

const project = ref({});

const updatePage = async () => {
  const userData = await $directus.request(readUsers());
  users.value = userData;

  // give users a score
  users.value.forEach((user) => {
    user.score = 0;
  });

  // rank users by score
  users.value.sort((a, b) => {
    return b.score - a.score;
  });

  // give users a rank
  users.value.forEach((user, index) => {
    user.rank = index + 1;
  });
};

project.value = useProject();

onMounted(async () => {
  await updatePage();
});
</script>

<template>
  <div class="w-full mr-24">
    <h1 class="text-4xl font-bold text-gray-200 text-center">Scoreboard</h1>
    <ol class="w-full mt-8">
      <li
        v-for="user in users"
        :key="user.id"
        class="bg-slate-900 odd:bg-slate-800 w-full rounded-lg p-4 my-2 shadow-lg"
      >
        <ScoreBoardUser :user="user" :unit="project.value?.units" />
      </li>
    </ol>
  </div>
</template>

<style scoped></style>
