<script setup lang="ts">
import { readMe, readRole, readUser } from "@directus/sdk";
import { useRoute } from "vue-router";
import { useDirectus } from "../../../composables/directus";

const { $directus } = useDirectus();
const route = useRoute();

const uuid = route.params.id;

const { data: user } = await useAsyncData(() => {
  if (uuid) {
    return $directus.request(readUser(uuid.toString(), { fields: ["first_name", "avatar", "role"] }));
  }
  return $directus.request(readMe({ fields: ["first_name", "avatar", "role"] }));
});
const { data: role } = await useAsyncData(() => {
  return $directus.request(readRole(user.value.role, { fields: ["name"] }));
});
</script>

<template>
  <div></div>
</template>

<style scoped></style>
