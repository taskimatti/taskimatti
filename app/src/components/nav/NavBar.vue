<script setup lang="ts">
import BottomNavButton from "./BottomNavButton.vue";
import { inject } from "vue";

const colorScheme = inject("colorscheme");
const user = inject("user");
</script>

<template>
  <div :class="['fixed bottom-0 bg-' + colorScheme + ' w-screen']">
    <div class="flex items-center justify-around gap-0 m-auto">
      <BottomNavButton text="Tasks" href="" />
      <BottomNavButton text="Scoreboard" href="scoreboard" />
      <BottomNavButton text="Account" href="account" />
      <BottomNavButton v-if="user.isAdmin" text="Admin" href="admin" />
    </div>
  </div>
</template>

<style scoped></style>