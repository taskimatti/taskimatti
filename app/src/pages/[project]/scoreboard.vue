<script setup lang="ts">
import { ref } from "vue";
import { readUsers } from "@directus/sdk";

const { $directus } = useNuxtApp();

const users = ref([]);

const updatePage = async () => {
  users.value = await $directus.request(readUsers());
};

await updatePage();

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
        <ScoreBoardUser :user="user" />
      </li>
    </ol>
  </div>
</template>

<style scoped></style>
