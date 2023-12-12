<script setup lang="ts">
import { readMe, readRole, readUser } from '@directus/sdk';
import { useRoute } from 'vue-router';
import { ref, onMounted, type Ref } from 'vue';
import { useDirectus } from '~/composables/directus';
import { logout as directusLogout } from '~/composables/auth';
import { useUser } from '~/composables/states';

const { $directus } = useDirectus();

const route = useRoute();
const uuid = ref(route.params.id);
const role: Ref<string> = ref('Loading...');
const user: Ref<User> = ref(useUser());

user.value.id = 'Loading...';
user.value.first_name = 'Loading...';
user.value.avatar = 'placeholder.jpg';

const fetchUserData = async (userId: string) => {
  try {
    const userData = await $directus.request(
      readUser(userId, {
        fields: ['id', 'first_name', 'avatar', 'role'],
      }),
    );
    user.value.id = userData.id;
    user.value.first_name = userData.first_name;
    user.value.avatar = userData.avatar;
    user.value.role = userData.role;

    await getRoleName(userData.role);
  } catch (error) {
    console.error('Failed to fetch user data:', error);
  }
};

const getRoleName = async (roleId: string) => {
  try {
    const roleData = await $directus.request(
      readRole(roleId, {
        fields: ['name'],
      }),
    );
    role.value = roleData.name;
  } catch (error) {
    console.error('Failed to fetch role name:', error);
  }
};

onMounted(async () => {
  if (uuid.value) {
    await fetchUserData(uuid.value.toString());
  } else {
    const meData = await $directus.request(readMe({ fields: ['id', 'first_name', 'avatar', 'role'] }));
    user.value.id = meData.id;
    user.value.first_name = meData.first_name;
    user.value.avatar = meData.avatar;
    user.value.role = meData.role;
    if (user.value.role) {
      await getRoleName(user.value.role);
    }
  }
});

const logout = async () => {
  const response = await directusLogout();
  if (response === 'success') {
    window.location.href = '/login';
  }
};
</script>
<template>
  <div>
    <client-only>
      <Account :key="user.id" :user="user" :role="role" :image="$directus.url.href + 'assets/' + user.avatar" />
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
