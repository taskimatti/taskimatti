<script setup lang="ts">
import { readMe, readRole, readUser } from "@directus/sdk";
import { useRoute } from "vue-router";
import { ref } from "vue";
import { useDirectus } from "../../composables/directus";

const { $directus } = useDirectus();

const route = useRoute();
const uuid = ref(route.params.id);

const { data: user } = await useAsyncData(() => {
  if (uuid.value) {
    return $directus.request(readUser(uuid.value.toString(), { fields: ["first_name", "avatar", "role"] }));
  }
  return $directus.request(readMe({ fields: ["first_name", "avatar", "role"] }));
});
const { data: role } = await useAsyncData(() => {
  return $directus.request(readRole(user.value.role, { fields: ["name"] }));
});
</script>

<template>
  <div>
    <Account :key="user.id" :user="user" :role="role.name" :image="$directus.url.href + 'assets/' + user.avatar" />
  </div>
</template>

<style scoped></style>
