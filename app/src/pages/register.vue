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
    role: 'fc9d4dbc-fbf7-4241-ad11-08816646bc00'
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
useSeoMeta({
  title: `Register`
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
          v-model="userName"
          type="text"
          placeholder="Username"
          class="text-black block w-full px-3 py-2 border-4 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
        />
        <input
          v-model="userEmail"
          type="email"
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
          @click.prevent="register"
          class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
        >
          register
        </button>
        <div>
          <p>
            Already have an account?
            <span>
              <nuxt-link to="/login" class="text-blue-500 hover:underline"> Login</nuxt-link>
            </span>
            now!
          </p>
        </div>
      </div>
    </div>
  </div>
</template>
