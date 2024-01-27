<script setup lang="ts">
import { readItems, readUsers } from '@directus/sdk';
import { useState } from 'nuxt/app';
import { useDirectus } from '~/composables/directus';
import { useRoles, useUser } from '~/composables/states';
import { ref } from 'vue';
import { useRoute } from 'vue-router';

const { $directus } = useDirectus();

let users: Ref<User[] | null> = useState(() => null);
const roles = useRoles();
const route = ref(useRoute());
const user: Ref<User> = useUser();

const fetchData = async () => {
  const { data: _project } = await useAsyncData(() => {
    return $directus.request(
      readItems(
        // @ts-ignore
        'Project',
        {
          filter: {
            id: {
              _eq: route.value?.params?.project?.toString(),
            },
          },
          fields: [
            'id, users.directus_users_id.id, users.directus_users_id.first_name, users.directus_users_id.avatar, users.directus_users_id.role, users.is_admin',
          ],
        },
      ),
    );
  });

  for (const _user of _project.value[0].users) {
    _user.id = _user.directus_users_id.id;
    _user.first_name = _user.directus_users_id.first_name;
    _user.avatar = _user.directus_users_id.avatar;
    _user.role = _user.directus_users_id.role;
    _user.is_project_admin = _user.is_admin;
  }
  const _users = ref(_project.value[0].users);

  if (_users.value !== null) {
    for (const _user of _users.value) {
      _user.role = roles.value?.find((role) => role.id === _user.role)?.name;
    }
  } else {
    _users.value = [];
  }
  users.value = _users.value;
};

await fetchData();

const isAdmin = roles.value?.find((role) => role.id === user.value?.role)?.admin_access;
</script>

<template>
  <div v-if="isAdmin" class="grid grid-cols-2 gap-4">
    <div v-for="user in users">
      <NuxtLink :to="'adminTaskView/' + user.id" :key="user.id">
        <Account :user="user" :role="user.role" :image="$directus.url.href + 'assets/' + user.avatar" />
      </NuxtLink>
    </div>
  </div>
  <div v-else class="flex flex-col items-center justify-center text-center text-white">
    <p class="my-4">
      You don't have access to this page. If you think this is a mistake, please contact your administrator.
    </p>
    <button
      class="px-4 py-2 font-bold text-white bg-blue-500 rounded hover:bg-blue-700"
      @click="() => $router.push('/')"
    >
      Go back home
    </button>
  </div>
</template>

<style scoped></style>
