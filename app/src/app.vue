<script setup lang="ts">
import { type Ref, ref } from 'vue';
import { useRoute } from 'vue-router';
import { readItems, readMe, readRoles } from '@directus/sdk';
import { useAssets, useOrganisation, useProject, useProjects, useRoles, useUser } from '~/composables/states';
import { useDirectus } from '~/composables/directus';
import { refresh } from '~/composables/auth';
import TopBar from '~/components/nav/TopBar.vue';
import NavBar from '~/components/nav/NavBar.vue';

const { $directus } = useDirectus();

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
      return $directus.request(
        readMe(
          // @ts-ignore
          { fields: ['email', 'first_name', 'last_name', 'avatar', 'role', 'id'] },
        ),
      );
    });
    if (_user.value && 'id' in _user.value) {
      useUser().value = { ...useUser().value, ..._user.value };
    }
  } else {
    // Redirect to login page if no token exists and page requires authentication
    if (!['/login', '/register', '', '/'].includes(window.location.pathname)) {
      window.location.href = '/';
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
  return $directus
    .request(
      readItems(
        // @ts-ignore
        'Organisation',
      ),
    )
    .catch((error) => {
      console.error(error);
    });
});

const user_id = useUser().value.id;

const { data: _projects } = await useAsyncData(() => {
  return $directus.request(
    readItems(
      // @ts-ignore
      'Project',
      {
        filter: {
          users: {
            directus_users_id: {
              id: {
                _eq: user_id,
              },
            },
          },
          status: {
            _eq: 'published',
          },
        },
        fields: [
          'name, image, description, scoreboard, status, units, id, colorScheme, users.directus_users_id.id, users.is_admin, users.role, users.role.name',
        ],
      },
    ),
  );
});

const { data: _roles } = await useAsyncData(() => {
  return $directus.request(
    readRoles(
      // @ts-ignore
      { fields: ['id', 'name', 'admin_access'] },
    ),
  );
});
if (_org.value && 'id' in _org.value) {
  org.value = { ...org.value, ..._org.value };
}

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
  <div class="min-h-screen bg-gradient-from-tl bg-gradient-to-br from-[#553757] via-[#DC7969] to-[#F9F871]">
    <TopBar />
    <div class="container px-8 py-16">
      <div class="min-h-[50vh]">
        <router-view />
      </div>
    </div>
    <NavBar />
  </div>
</template>
