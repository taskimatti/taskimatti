<script setup lang="ts">
import { readMe, readRole } from "@directus/sdk";
import BottomNavButton from "./BottomNavButton.vue";

const { $directus, $readItems } = useNuxtApp();

const { data: Organisation } = await useAsyncData("Organisation", () => {
  return $directus.request($readItems("Organisation"));
});

const { data: user } = await useAsyncData(() => {
  return $directus.request(readMe({ fields: ["role"] }));
});

const { data: role } = await useAsyncData(() => {
  return $directus.request(readRole(user.value.role));
});
</script>

<template>
  <div
    class="fixed bottom-0 w-full max-w-lg"
    :style="'background: ' + Organisation.color_scheme + ';'"
  >
    <div class="flex items-center justify-around gap-0 m-auto">
      <BottomNavButton text="Tasks" href="" />
      <BottomNavButton text="Scoreboard" href="scoreboard" />
      <BottomNavButton text="Account" href="account" />
      <BottomNavButton v-if="role.admin_access" text="Admin" href="admin" />
    </div>
  </div>
</template>

<style scoped></style>
