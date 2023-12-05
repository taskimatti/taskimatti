<script setup lang="ts">
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

import { ref, watch } from "vue";
import { useRoute } from "vue-router";
import { useProject, useUser, useRoles } from "../../composables/states";

let path = ref("");
const role = ref({});
const _project = ref({});
const project = ref("");

const updatePage = async () => {
  const route = useRoute();
  path.value = route.path.toString();

  _project.value = useProject();
  project.value = _project.value.id;
  const _user = useUser();
  const _roles = useRoles();
  role.value = _roles.value.find((role) => role.id === _user.value.role);

  if (process.client) {
    localStorage.setItem("project", _project?.value?.toString());
  }
};

await updatePage();

watch(
  () => path.value,
  async (newPath) => {
    path.value = newPath;
    console.log("UPDATING");
    await updatePage();
  },
);

watch(
  () => _project.value,
  async (newProject) => {
    _project.value = newProject;
    console.log("UPDATING");
    await updatePage();
  },
);

watch(
  () => project.value,
  async (newProject) => {
    project.value = newProject;
    console.log("UPDATING");
    await updatePage();
  },
);

watch(
  () => role.value,
  async (newRole) => {
    role.value = newRole;
    console.log("UPDATING");
    await updatePage();
  },
);
</script>

<template>
  <nav class="fixed bottom-0 w-full max-w-lg h-16" role="tablist" :style="'background: ' + _project.colorScheme + ';'">
    <div class="flex items-center justify-around gap-0 m-auto">
      <nuxt-link :to="'/' + project" class="p-4 h-full w-full flex justify-center items-center flex-col">
        <CheckBadgeIconSolid v-if="!path.split('/')[2]" class="h-6 w-6 text-white" />
        <CheckBadgeIconOutline v-else class="h-6 w-6 text-white" />
        <p class="text-white text-sm">Tasks</p>
      </nuxt-link>
      <nuxt-link
        v-if="path.split('/')[1]?.length == 36"
        :to="'/' + project + '/scoreboard'"
        class="p-4 h-full w-full flex justify-center items-center flex-col"
      >
        <ChartBarIconSolid v-if="path.split('/')[2] === 'scoreboard'" class="h-6 w-6 text-white" />
        <ChartBarIconOutline v-else class="h-6 w-6 text-white" />
        <p class="text-white text-sm">Scoreboard</p>
      </nuxt-link>
      <nuxt-link :to="'/' + project + '/account'" class="p-4 h-full w-full flex justify-center items-center flex-col">
        <UserIconSolid v-if="path.split('/')[2] === '/account'" class="h-6 w-6 text-white" />
        <UserIconOutline v-else class="h-6 w-6 text-white" />

        <p class="text-white text-sm">Account</p>
      </nuxt-link>
      <nuxt-link
        v-if="role.admin_access"
        :to="'/' + project + '/admin'"
        class="p-4 h-full w-full flex justify-center items-center flex-col"
      >
        <SparklesIconSolid v-if="path.split('/')[2] === 'admin'" class="h-6 w-6 text-white" />
        <SparklesIconOutline v-else class="h-6 w-6 text-white" />

        <p class="text-white text-sm">Admin</p>
      </nuxt-link>
    </div>
  </nav>
</template>

<style scoped></style>
