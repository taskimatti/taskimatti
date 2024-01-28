<script setup lang="ts">
import { type Ref, ref } from 'vue';
import { useSeoMeta } from '@unhead/vue';
import { useAssets, useOrganisation, useProjects, useUser } from '~/composables/states';

const org: Ref<Organisation> = ref(useOrganisation().value);
const user: Ref<User> = ref(useUser().value);
const projects: Ref<Project[] | null> = ref(useProjects().value);
const assets: Ref<String | null> = ref('');

const updatePage = async () => {
  org.value = useOrganisation().value;
  user.value = useUser().value;
  if (user.value.email) {
    projects.value = useProjects().value;
  }
  assets.value = useAssets().value;

  useSeoMeta({
    title: org.value?.name || 'Taskimatti',
    description: org.value.description,
  });
};

const logout = () => {
  window.localStorage.removeItem('access_token');
  window.localStorage.removeItem('refresh_token');
  window.location.href = '/';
};

while (true) {
  await updatePage();
  await new Promise((resolve) => setTimeout(resolve, 50));
  if (org.value && assets.value) break;
}
</script>

<template>
  <div class="min-h-screen -my-8">
    <div class="flex justify-center items-center flex-col">
      <div v-if="user.email">
        <div class="organisation flex justify-center flex-col">
          <div class="flex justify-around items-center">
            <NuxtImg
              :src="assets + org.image"
              class="w-16 h-16 object-cover rounded-full"
              width="128"
              height="128"
              quality="10"
              placeholder="/images/placeholder.svg"
              :alt="org.name || 'Organisation image'"
            />
            <h1 class="text-center text-3xl p-4 pb-6">{{ org.name }}</h1>
          </div>
          <h2 class="text-center text-xl p-4 pb-6">{{ org.description }}</h2>
        </div>

        <h2 class="text-center text-3xl pb-2">Welcome,</h2>
        <h2 class="text-center text-2xl font-bold pb-4">{{ user.first_name }}!</h2>
        <div class="flex flex-col justify-center items-center">
          <nuxt-link to="/">
            <button
              @click="logout"
              class="group relative flex justify-center my-4 py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500"
            >
              Logout
            </button>
          </nuxt-link>
        </div>

        <div class="flex flex-col justify-center items-center gap-5">
          <h2 class="text-3xl p-4">Select project</h2>
          <ol>
            <li class="mb-6" v-for="project in projects" :key="project.id">
              <NuxtLink
                :to="
                  project.users &&
                  project.users.filter((_user) => _user.directus_users_id?.id === user.id)[0].role.name === 'Parent'
                    ? project.id + '/admin'
                    : project.id
                "
              >
                <div class="rounded-lg shadow-lg overflow-hidden" :style="'background: ' + project.colorScheme">
                  <NuxtImg
                    :src="assets + project.image"
                    class="w-full h-32 object-cover"
                    width="384"
                    height="128"
                    quality="10"
                    placeholder="/images/placeholder.svg"
                    :alt="project.name || 'Project image'"
                  />
                  <div class="p-6">
                    <div class="flex justify-between">
                      <h2 class="text-2xl font-bold mb-2">{{ project.name }}</h2>
                      <p
                        v-if="
                          project.users &&
                          project.users.filter((_user) => _user.directus_users_id?.id === user.id)[0].role.name ===
                            'Parent'
                        "
                      >
                        <span title="You are an admin of this project">✨</span>
                      </p>
                    </div>
                    <p class="text-gray-300">{{ project.description }}</p>
                  </div>
                </div>
              </NuxtLink>
            </li>
          </ol>
        </div>
      </div>
      <div v-else>
        <div class="organisation flex justify-center flex-col">
          <div class="flex justify-around items-center">
            <NuxtImg
              :src="assets + org.image"
              class="w-64 h-64 object-cover rounded-full"
              width="128"
              height="128"
              quality="10"
              placeholder="/images/placeholder.svg"
              :alt="org.name || 'Organisation image'"
            />
          </div>
          <div class="p-4">
            <h1 class="text-center text-2xl py-1">Welcome to</h1>
            <h1 class="text-center text-3xl py-1">{{ org.name }}!</h1>
          </div>

          <h2 class="text-center text-lg p-4 pb-6">{{ org.description }}</h2>
        </div>
        <div class="flex flex-col justify-center items-center pt-12">
          <p class="text-center pb-4 text-xl">Please login or register to continue.</p>
          <div class="w-full">
            <nuxt-link to="/login">
              <button
                class="group relative w-full flex justify-center my-4 py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-[#553757] hover:bg-[#755777] focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
              >
                Login
              </button>
            </nuxt-link>
            <nuxt-link to="/register">
              <button
                class="group relative w-full flex justify-center my-4 py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-[#553757] hover:bg-[#755777] focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
              >
                Register
              </button>
            </nuxt-link>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped></style>
