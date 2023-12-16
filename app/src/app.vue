<script setup lang="ts">
import { type Ref, ref } from 'vue';
import { useRoute } from 'vue-router';
import { readMe, readRoles } from '@directus/sdk';
import { useAssets, useOrganisation, useProject, useProjects, useRoles, useUser } from '~/composables/states';
import { useDirectus } from '~/composables/directus';
import { refresh } from '~/composables/auth';
import TopBar from '~/components/nav/TopBar.vue';
import NavBar from '~/components/nav/NavBar.vue';

const { $directus, $readItems } = useDirectus();

if (process.client) {
  const token = window.localStorage.getItem('access_token');
  if (token) {
    $directus.setToken(token);
    // Refresh the token
    if (window.location.pathname !== '/login') {
      if (window.localStorage.getItem('refresh_token')) {
        const response = await refresh();
        if (response === 401) {
          window.location.href = '/login';
        }
      }
    }

    // Fetch user data only when a valid token exists
    const { data: _user } = await useAsyncData(() => {
      return $directus.request(readMe({ fields: ['role'] }));
    });
    useUser().value.role = _user.value?.role;
  } else {
    // Redirect to login page if no token exists and page requires authentication
    if (!['/login', '/register'].includes(window.location.pathname)) {
      window.location.href = '/login';
    }
  }
}

const route = useRoute();

const uuid = ref(route?.params?.project?.toString());

const org = useOrganisation();
const projects: Ref<[Project] | null> = useProjects();
const project = useProject();
const roles = useRoles();
const assets: Ref<String | null> = useAssets();

const { data: _org } = await useAsyncData(() => {
  return $directus.request($readItems('Organisation'));
});

const { data: _projects } = await useAsyncData(() => {
  return $directus.request($readItems('Project'));
});

const { data: _roles } = await useAsyncData(() => {
  return $directus.request(readRoles({ fields: ['id', 'name', 'admin_access'] }));
});

org.value = { ...org.value, ..._org.value };

if (_projects.value && 'id' in _projects.value) {
  projects.value = [_projects.value as unknown as Project];
} else {
  projects.value = _projects.value as unknown as [Project];
}

if (_roles.value && 'id' in _roles.value) {
  roles.value = [_roles.value as unknown as Role];
} else {
  roles.value = _roles.value as unknown as [Role];
}

if (uuid.value) {
  const foundProject = projects.value?.find((project) => project.id === uuid.value);
  if (foundProject) {
    project.value = foundProject;
  } else {
    window.location.href = '/';
  }
}
assets.value = $directus.url.href + 'assets/';
</script>

<template>
  <div class="min-h-screen bg-gray-900">
    <TopBar />
    <div class="container">
      <div class="min-h-[50vh]">
        <router-view />
      </div>
    </div>
    <NavBar />
  </div>
</template>