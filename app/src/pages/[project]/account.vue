<script setup lang="ts">
import { readMe, readRole, readUser } from "@directus/sdk";
import { useRoute } from "vue-router";
import { ref, onMounted } from "vue";
import { useDirectus } from "~/composables/directus";
import { logout as directusLogout } from "~/composables/auth";

const { $directus } = useDirectus();

const route = useRoute();
const uuid = ref(route.params.id);
const role = ref({});

// Initialize user and role with placeholder data
const user = ref({
  first_name: "Loading...",
  avatar: "a4a04573-ed55-4c7d-b81f-efb13d5b768c",
  role: "Loading...",
});

role.value = "Loading...";

onMounted(async () => {
  if (uuid.value) {
    const userData = await $directus.request(
        readUser(uuid.value.toString(), {
          fields: ["first_name", "avatar", "role"],
        }),
    );
    user.value = userData;
  } else {
    const meData = await $directus.request(
        readMe({ fields: ["first_name", "avatar", "role"] }),
    );
    user.value = meData;
  }

  const roleData = await $directus.request(readRole(user?.value?.role, { fields: ["name"] }));
  role.value = roleData.name;

});

const logout = async () => {
  const response = await directusLogout();
  if (response === "success") {
    window.location.href = "/login";
  }
};
</script>
<template>
  <div>
    <client-only>
      <Account
          :key="user.id"
          :user="user"
          :role="role"
          :image="$directus.url.href + 'assets/' + user.avatar"
      />
    </client-only>
  </div>
  <button
      @click="logout"
      class="group relative w-full mt-5 flex justify-center py-2 px-4 text-sm font-medium rounded-md text-white bg-red-500 hover:bg-red-600"
  >
    Logout
  </button>
</template>

<style scoped></style>