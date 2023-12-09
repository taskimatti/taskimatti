<script setup lang="ts">
import { readMe, readRole, readSettings, readUser } from "@directus/sdk";
import { useRoute } from "vue-router";
import { ref } from "vue";
import { useDirectus } from "../../composables/directus";
import { logout as directusLogout } from "../../composables/auth";

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

const logout = async () => {
  const response = await directusLogout();
  if(response.errors){
    console.log(response.errors[0].message);
  }
  window.location.href = "/login";
};

</script>
<template>
  <div>
    <Account :key="user.id" :user="user" :role="role.name" :image="$directus.url.href + 'assets/' + user.avatar" />
  </div>
  <button @click="logout"
    class="group relative w-full mt-5 flex justify-center py-2 px-4 text-sm font-medium rounded-md text-white bg-red-500 hover:bg-red-600 ">
    Logout
  </button>
</template>

<style scoped></style>
