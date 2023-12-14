<script setup lang="ts">
import { readUsers } from '@directus/sdk';
import { useState } from 'nuxt/app';
import { useDirectus } from '~/composables/directus';
import { useRoles, useUser } from '~/composables/states';

const { $directus } = useDirectus();

let users: Ref<User[] | null> = useState(() => null);
const roles = useRoles();
const user: Ref<User> = useUser();

const fetchData = async () => {
  const { data: _users } = useAsyncData(() => {
    return $directus.request(readUsers({ fields: ['id', 'first_name', 'avatar', 'role'] }));
  });

  if (_users.value !== null) {
    for (const _user of _users.value) {
      _user.role = _user.role.id;
    }
  } else {
    _users.value = [];
  }
};

await fetchData();

const isAdmin = roles.value?.find((role) => role.id === user.value?.role)?.admin_access;
</script>

<template>
  <div v-if="isAdmin" class="grid grid-cols-2 gap-4">
    <div v-for="user in users">
      <NuxtLink :to="'account/' + user.id" :key="user.id">
        <Account
          :user="user"
          :role="roles?.find((role) => role.id === user.role).name"
          :image="$directus.url.href + 'assets/' + user.avatar"
        />
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
