<script setup lang="ts">
import data from "~/data/users.json";
import type DefaultUser from "~/types";

const users: DefaultUser[] = data.data;

users.sort((a, b) => b.points - a.points);
</script>

<template>
  <div class="flex justify-center mx-8 mt-16">
    <div class="w-full">
      <ol class="w-full">
        <li
          v-for="user in users"
          class="list-decimal bg-slate-900 odd:bg-slate-800 w-full"
        >
          <ScoreBoardUser :user="user" />
        </li>
      </ol>
    </div>
  </div>
</template>

<style scoped></style>
