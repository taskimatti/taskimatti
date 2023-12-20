<script setup lang="ts">
import { type Ref, ref } from 'vue';
import { login as directusLogin } from '~/composables/auth';
import { useSeoMeta } from '@unhead/vue';
import { useDirectus } from '~/composables/directus';
import { useOrganisation } from '~/composables/states';

let userEmail = ref('');
let userPass = ref('');
let msg = ref('');

const { $directus, $readItem } = useDirectus();

const { data: _org } = await useAsyncData(() => {
  return $directus.request($readItem('Organisation', '1'));
});

const org: Ref<Organisation> = ref(useOrganisation());
org.value = { ...org.value, ..._org.value };

const login = async () => {
  const credentials = {
    email: userEmail.value.toString(),
    password: userPass.value.toString(),
  };
  const response = await directusLogin(credentials);
  if (response === 'success') {
    window.location.href = '/';
  } else if (response !== null) {
    msg.value = response;
  }
};
useSeoMeta({
  title: `${org.value?.name} | Login`,
  description: org.value?.description,
  ogImage: `${$directus.url.href}assets/${org.value?.image}`,
  themeColor: org.value?.color_scheme,
});
</script>

<template>
  <div class="flex flex-col justify-center py-12 sm:px-6 lg:px-8">
    <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
      <img
        src="/images/logo.svg"
        alt="TaskiMatti logo"
        class="h-full w-56 rounded-3xl p-12 mx-auto my-5 bg-white"
      />

      <div class="bg-gray-800 py-8 px-4 sm:rounded-lg sm:px-10 space-y-6">
        <input
          v-model="userEmail"
          type="text"
          placeholder="Email"
          class="text-black block w-full px-3 py-2 border-4 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
        />
        <input
          v-model="userPass"
          type="password"
          placeholder="Password"
          class="text-black block w-full px-3 py-2 border-4 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
        />
        <p class="text-red-500 text-xs italic">{{ msg }}</p>
        <button
          @click="login"
          class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
        >
          Login
        </button>
        <div>
          <p>
            Don't have an account yet?
            <span>
              <nuxt-link to="/register" class="text-blue-500 hover:underline"> Register</nuxt-link>
            </span>
            now!
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped></style>
