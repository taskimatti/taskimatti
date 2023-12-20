<script setup lang="ts">
import { ref } from 'vue';
import { register as directusRegister } from '../composables/auth';
import { login as directusLogin } from '~/composables/auth';

let userEmail = ref('');
let userPass = ref('');
let userName = ref('');
let msg = ref('');

const register = async () => {
  const credentials = {
    first_name: userName.value.toString(),
    email: userEmail.value.toString(),
    password: userPass.value.toString(),
  };
  if (credentials.first_name === '' || null) {
    msg.value = 'Username is required';
    return;
  }
  if (credentials.password === '' || null) {
    msg.value = 'Password is required';
    return;
  }
  if (credentials.email === '' || null) {
    msg.value = 'Email is required';
    return;
  }
  const response = await directusRegister(credentials);
  if (response === 'success') {
    // login after register
    const response = await directusLogin(credentials);
    if (response === 'success') {
      window.location.href = '/';
    } else if (response !== null) {
      msg.value = response;
    }
  } else if (response !== null) {
    msg.value = response;
  }
};
</script>
<template>
  <div>
    <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
      <NuxtImg
        src="/images/logo.svg"
        alt="TaskiMatti logo"
        class="h-full w-56 rounded-3xl p-12 mx-auto my-5 bg-white"
      />
    </div>
    <form class="bg-slate-800 shadow-md rounded-3xl px-8 pt-6 pb-8 mb-4">
      <div class="mb-4">
        <label class="block text-white text-sm font-bold mb-2" for="name"> Username: </label>
        <input
          v-model="userName"
          class="border rounded w-full py-2 px-3 text-gray-700 focus:outline-none"
          id="name"
          type="text"
          required
        />
      </div>
      <div class="mb-4">
        <label class="block text-white text-sm font-bold mb-2" for="email"> Email: </label>
        <input
          v-model="userEmail"
          class="border rounded w-full py-2 px-3 text-gray-700 focus:outline-none"
          id="email"
          type="email"
          required
        />
      </div>
      <div class="mb-4">
        <label class="block text-white text-sm font-bold mb-2" for="password"> Password: </label>
        <input
          v-model="userPass"
          class="border rounded w-full py-2 px-3 text-gray-700 focus:outline-none"
          id="password"
          type="password"
          required
        />
      </div>
      <div class="flex items-center justify-between">
        <p class="text-red-500 text-xs italic">{{ msg }}</p>
        <button
          @click.prevent="register"
          class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
          type="submit"
        >
          Register
        </button>
      </div>
      <div>
        <p>
          Already have an account?
          <span> <nuxt-link to="/login" class="text-blue-500 hover:underline">Login</nuxt-link> now! </span>
        </p>
      </div>
    </form>
  </div>
</template>
