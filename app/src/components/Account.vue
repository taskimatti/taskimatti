<script setup lang="ts">
import {
  ChartBarIcon as ChartBarIconSolid,
  CheckBadgeIcon as CheckBadgeIconSolid,
  SparklesIcon as SparklesIconSolid,
  UserIcon as UserIconSolid,
} from '@heroicons/vue/24/solid';

let userPass = ref('');
let userName = ref('');
let msg = ref('');

const props = defineProps({
  user: {
    type: Object as () => User,
    required: true,
  },
  role: {
    type: String,
    required: true,
  },
  image: {
    type: String,
    Grequired: true,
  },
});
const updateEmail = async () => {
  const credentials = {
    first_name: userName.value.toString(),
    role: 'fc9d4dbc-fbf7-4241-ad11-08816646bc00',
  };
};

const updateUserName =async () => {

  
}
</script>

<template>
  <div class="bg-gray-800 p-6 mt-6 rounded-lg shadow-md w-full">
    <NuxtImg :src="image.endsWith('null') ? '/images/avatar.jpg' : image" placeholder="/images/avatar.jpg" alt="Avatar"
      width="100" height="100" class="h-32 w-32 object-cover rounded-full border-2 border-gray-600" />
    <h2 class="text-2xl text-white mt-4">{{ user.first_name }}</h2>
  <div class="bg-gray-800 p-6 rounded-lg shadow-md w-full">
    <NuxtImg
      :src="image.endsWith('null') ? '/images/avatar.jpg' : image"
      placeholder="/images/avatar.jpg"
      alt="Avatar"
      width="100"
      height="100"
      class="h-32 w-32 object-cover rounded-full border-2 border-gray-600"
    />
    <div class="flex flex-row justify-between mt-4">
      <h2 class="text-2xl text-white">{{ user.first_name }}</h2>
      <p v-if="user?.is_project_admin">
        <span title="Admin in this project">✨</span>
      </p>
    </div>
    <p class="text-gray-400">{{ role }}</p>
    <div class="p-5 mt-5 border rounded-3xl">
      <h1 class="mb-2">Edit Profile:</h1>
      <div>
        <input v-model="userName" placeholder='New UserName' type="text"
        class="text-black w-full px-auto -py-4 border-4 rounded-md focus:outline-none"/>
        <button class="text-slate-400 underline float-right">save</button>
      </div>
      <div>
        <input v-model="userPass" placeholder='New Password' type="password"
        class="text-black w-full px-auto -py-4 border-4 rounded-md focus:outline-none"/>
        <button class="text-slate-400 underline float-right">save</button>
      </div>
    </div>
  </div>
</template>

<style scoped></style>
