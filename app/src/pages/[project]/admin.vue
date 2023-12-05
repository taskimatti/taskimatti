<script setup lang="ts">
import { readRoles, readUsers } from "@directus/sdk";
import { useState } from "nuxt/app";

const { $directus } = useNuxtApp();

let users = useState(() => {});
let roles = useState(() => {});

const fetchData = async () => {
  const { data: _users } = useAsyncData(() => {
    return $directus.request(readUsers({ fields: ["id", "first_name", "avatar", "role"] }));
  });

  const { data: _roles } = useAsyncData(() => {
    return $directus.request(readRoles({ fields: ["id", "name"] }));
  });

  users.value = _users;
  roles.value = _roles;
};
await fetchData();
</script>

<template>
  <div class="grid grid-cols-2 gap-4">
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
</template>

<style scoped></style>
