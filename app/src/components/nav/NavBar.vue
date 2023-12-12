<script setup lang="ts">
import {
  ChartBarIcon as ChartBarIconSolid,
  CheckBadgeIcon as CheckBadgeIconSolid,
  SparklesIcon as SparklesIconSolid,
  UserIcon as UserIconSolid,
} from '@heroicons/vue/24/solid';
import {
  ChartBarIcon as ChartBarIconOutline,
  CheckBadgeIcon as CheckBadgeIconOutline,
  SparklesIcon as SparklesIconOutline,
  UserIcon as UserIconOutline,
} from '@heroicons/vue/24/outline';
import { type Ref, ref, watch } from 'vue';
import { useRoute } from 'vue-router';
import { useAssets, useProject, useProjects, useRoles, useUser } from '~/composables/states';
import { useSeoMeta } from '@unhead/vue';

const route = useRoute();
const uuid: Ref<string> = ref(''); // project uuid
const page: Ref<string | undefined> = ref(''); // current page
const project: Ref<Project | null> = ref(null);
const role: Ref<Role | null> = ref(null);
const assets: Ref<String | null> = ref(useAssets().value);

const updatePage = async () => {
  uuid.value = route.path.split('/')[1];
  page.value = route.path.split('/')[2];

  const foundProject = useProjects().value?.find((p) => p.id === uuid.value);

  const _user: Ref<User> = useUser();
  const _roles: Ref<Role[] | null> = useRoles();

  if (foundProject) {
    project.value = foundProject;
    useProject().value = { ...foundProject };
  } else {
    project.value = null;
    useProject().value.id = undefined;
  }

  if (_user.value && _roles.value) {
    role.value = _roles.value.find((_role) => _role.id === _user.value.role)!;
  }
  useSeoMeta({
    title: `${project.value?.name} | ${
      page.value ? page.value?.charAt(0).toUpperCase() + page.value?.slice(1) : 'Tasks'
    }`,
    description: project.value?.description,
  });
};

watch(
  () => route.path,
  async () => {
    await updatePage();
  },
);

if (process.client) {
  await updatePage();
}
</script>
<template>
  <div>
    <nav
      v-if="uuid"
      class="fixed bottom-0 w-full max-w-lg h-16"
      role="tablist"
      :style="'background: ' + project?.colorScheme + ';'"
    >
      <div class="flex items-center justify-around gap-0 m-auto">
        <nuxt-link :to="'/' + uuid" class="p-4 h-full w-full flex justify-center items-center flex-col">
          <CheckBadgeIconSolid v-if="page == undefined" class="h-6 w-6 text-white" />
          <CheckBadgeIconOutline v-else class="h-6 w-6 text-white" />
          <p class="text-white text-sm">Tasks</p>
        </nuxt-link>
        <nuxt-link
          v-if="route.path.split('/')[1]?.length == 36"
          :to="'/' + uuid + '/scoreboard'"
          class="p-4 h-full w-full flex justify-center items-center flex-col"
        >
          <ChartBarIconSolid v-if="page === 'scoreboard'" class="h-6 w-6 text-white" />
          <ChartBarIconOutline v-else class="h-6 w-6 text-white" />
          <p class="text-white text-sm">Scoreboard</p>
        </nuxt-link>
        <nuxt-link :to="'/' + uuid + '/account'" class="p-4 h-full w-full flex justify-center items-center flex-col">
          <UserIconSolid v-if="page === 'account'" class="h-6 w-6 text-white" />
          <UserIconOutline v-else class="h-6 w-6 text-white" />

          <p class="text-white text-sm">Account</p>
        </nuxt-link>
        <nuxt-link
          v-if="role?.admin_access"
          :to="'/' + uuid + '/admin'"
          class="p-4 h-full w-full flex justify-center items-center flex-col"
        >
          <SparklesIconSolid v-if="page === 'admin'" class="h-6 w-6 text-white" />
          <SparklesIconOutline v-else class="h-6 w-6 text-white" />

          <p class="text-white text-sm">Admin</p>
        </nuxt-link>
      </div>
    </nav>
  </div>
</template>

<style scoped></style>
