<script setup lang="ts">
import { readMe, readRole } from "@directus/sdk";
import {
  CheckBadgeIcon as CheckBadgeIconSolid,
  ChartBarIcon as ChartBarIconSolid,
  UserIcon as UserIconSolid,
  SparklesIcon as SparklesIconSolid,
} from "@heroicons/vue/24/solid";
import {
  CheckBadgeIcon as CheckBadgeIconOutline,
  ChartBarIcon as ChartBarIconOutline,
  UserIcon as UserIconOutline,
  SparklesIcon as SparklesIconOutline,
} from "@heroicons/vue/24/outline";

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
  <nav
    class="fixed bottom-0 w-full max-w-lg h-16"
    role="tablist"
    :style="'background: ' + Organisation.color_scheme + ';'"
  >
    <div class="flex items-center justify-around gap-0 m-auto">
      <nuxt-link to="/" class="p-4 h-full w-full flex justify-center items-center flex-col">
        <CheckBadgeIconSolid v-if="$route.path === '/'" class="h-6 w-6 text-white" />
        <CheckBadgeIconOutline v-else class="h-6 w-6 text-white" />

        <p class="text-white text-sm">Tasks</p>
      </nuxt-link>
      <nuxt-link to="/scoreboard" class="p-4 h-full w-full flex justify-center items-center flex-col">
        <ChartBarIconSolid v-if="$route.path === '/scoreboard'" class="h-6 w-6 text-white" />
        <ChartBarIconOutline v-else class="h-6 w-6 text-white" />

        <p class="text-white text-sm">Scoreboard</p>
      </nuxt-link>
      <nuxt-link to="/account" class="p-4 h-full w-full flex justify-center items-center flex-col">
        <UserIconSolid v-if="$route.path === '/account'" class="h-6 w-6 text-white" />
        <UserIconOutline v-else class="h-6 w-6 text-white" />

        <p class="text-white text-sm">Account</p>
      </nuxt-link>
      <nuxt-link
        v-if="role.admin_access"
        to="/admin"
        class="p-4 h-full w-full flex justify-center items-center flex-col"
      >
        <SparklesIconSolid v-if="$route.path === '/admin'" class="h-6 w-6 text-white" />
        <SparklesIconOutline v-else class="h-6 w-6 text-white" />

        <p class="text-white text-sm">Admin</p>
      </nuxt-link>
    </div>
  </nav>
</template>

<style scoped></style>
