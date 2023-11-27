<script setup lang="ts">
import BottomNavButton from "./BottomNavButton.vue";
</script>

<template>
  <div class="fixed bottom-0 bg-slate-900 w-screen">
    <div class="flex items-center justify-around gap-0 m-auto">
      <BottomNavButton text="Tasks" href="" />
      <BottomNavButton text="Scoreboard" href="scoreboard" />
      <BottomNavButton text="Account" href="account" />
      <BottomNavButton text="Admin" href="admin" />
    </div>
  </div>
</template>

<style scoped></style>
