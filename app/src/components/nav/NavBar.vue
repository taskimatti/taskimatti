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
import { onBeforeRouteUpdate, useRoute } from "vue-router";
import { useProject, useUser, useRoles } from "../../composables/states";

const route = ref(useRoute());
const _project = ref({});
const project = ref("");
const role = ref({});

const updatePage = async () => {
  const _route = useRoute();
  const path = _route.path.toString();

  _project.value = useProject();
  project.value = _project.value.value.id;
  const _user = useUser();
  const _roles = useRoles();
  role.value = _roles.value.find((_role) => _role.id === _user.value.role);
};

await updatePage();

// onBeforeRouteUpdate(async (to, from) => {
//   if (to.path !== from.path) {
//     await updatePage();
//   }
// });

watch(
  () => _project.value,
  async (newProject) => {
    _project.value = newProject;
    await updatePage();
  },
);

watch(
  () => project.value,
  async (newProject) => {
    project.value = newProject;
    await updatePage();
  },
);

watch(
  () => role.value,
  async (newRole) => {
    role.value = newRole;
    await updatePage();
  },
);
</script>
<template>
  <nav
    v-if="_project.value.id"
    class="fixed bottom-0 w-full max-w-lg h-16"
    role="tablist"
    :style="'background: ' + _project.value.colorScheme + ';'"
  >
    <div class="flex items-center justify-around gap-0 m-auto">
      <nuxt-link :to="'/' + project" class="p-4 h-full w-full flex justify-center items-center flex-col">
        <CheckBadgeIconSolid v-if="route.path.split('/')[2] === undefined" class="h-6 w-6 text-white" />
        <CheckBadgeIconOutline v-else class="h-6 w-6 text-white" />
        <p class="text-white text-sm">Tasks</p>
      </nuxt-link>
      <nuxt-link
        v-if="route.path.split('/')[1]?.length == 36"
        :to="'/' + project + '/scoreboard'"
        class="p-4 h-full w-full flex justify-center items-center flex-col"
      >
        <ChartBarIconSolid v-if="route.path.split('/')[2] === 'scoreboard'" class="h-6 w-6 text-white" />
        <ChartBarIconOutline v-else class="h-6 w-6 text-white" />
        <p class="text-white text-sm">Scoreboard</p>
      </nuxt-link>
      <nuxt-link :to="'/' + project + '/account'" class="p-4 h-full w-full flex justify-center items-center flex-col">
        <UserIconSolid v-if="route.path.split('/')[2] === 'account'" class="h-6 w-6 text-white" />
        <UserIconOutline v-else class="h-6 w-6 text-white" />

        <p class="text-white text-sm">Account</p>
      </nuxt-link>
      <nuxt-link
        v-if="role.admin_access"
        :to="'/' + project + '/admin'"
        class="p-4 h-full w-full flex justify-center items-center flex-col"
      >
        <SparklesIconSolid v-if="route.path.split('/')[2] === 'admin'" class="h-6 w-6 text-white" />
        <SparklesIconOutline v-else class="h-6 w-6 text-white" />

        <p class="text-white text-sm">Admin</p>
      </nuxt-link>
    </div>
  </nav>
</template>

<style scoped></style>
