<script setup lang="ts">
import { readMe, readRole, readUser } from "@directus/sdk";

const { $directus } = useNuxtApp();

const props = defineProps({
  uuid: {
    type: String,
    required: false,
    default: null,
  },
});

const { data: user } = await useAsyncData(() => {
  if (props.uuid) {
    return $directus.request(readUser(props.uuid, { fields: ["first_name", "avatar", "role"] }));
  }
  return $directus.request(readMe({ fields: ["first_name", "avatar", "role"] }));
});

const { data: role } = await useAsyncData(() => {
  return $directus.request(readRole(user.value.role, { fields: ["name"] }));
});

</script>

<template>
  <div class="bg-gray-800 p-6 rounded-lg shadow-md">
    <NuxtImg
      :src="$directus.url.href + 'assets/' + user.avatar"
      alt="avatar"
      width="100"
      height="100"
      class="object-cover rounded-full border-2 border-gray-600"
    />
    <h2 class="text-2xl text-white mt-4">{{ user.first_name }}</h2>
    <p class="text-gray-400">{{ role.name }}</p>
  </div>
</template>

<style scoped></style>
