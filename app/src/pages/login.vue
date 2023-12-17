<script setup lang="ts">
import { type Ref, ref } from 'vue';
import { login as directusLogin } from '~/composables/auth';
import { useSeoMeta } from '@unhead/vue';
import { useDirectus } from '~/composables/directus';
import { useOrganisation } from '~/composables/states';

// Modal windows
import ModalConfirm from '~/components/ModalConfirm.vue';

const show = ref(false);

const openConfirm = () => {
    show.value = true;
}

const closeConfirm = () => {
    show.value = false;
}

// Log in info
let userEmail = ref('');
let userPass = ref('');

let msg = ref('');

const { $directus, $readItem } = useDirectus();

const { data: _org } = await useAsyncData(() => {
  return $directus.request($readItem('Organisation', '1'));
});

const org: Ref<Organisation> = ref(useOrganisation());
org.value = { ...org.value, ..._org.value };
console.log(org.value);

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

    <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md space-y-8">

      <h1 class="text-5xl text-center text-cringe_boxtext3 ">
        Taskimatti
      </h1>

      <img
        src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTM0IiBoZWlnaHQ9IjE2NSIgdmlld0JveD0iMCAwIDEzNCAxNjUiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHk9IjMxIiB3aWR0aD0iMTM0IiBoZWlnaHQ9IjEzNCIgcng9IjEwIiBmaWxsPSIjRTVCNTY3Ii8+CjxyZWN0IHg9IjM1IiB3aWR0aD0iNjQiIGhlaWdodD0iMjIiIGZpbGw9IiNFNUI1NjciLz4KPC9zdmc+Cg=="
        alt="TaskiMatti logo"
        class="h-full w-56 rounded-3xl p-12 mx-auto my-5"
      />

      <p class="text-xl text-center text-cringe_text">
        Taskimatti on palvelu jota voidaan käyttää kaikkiin taskimattia vaativiin juttuihin
      </p>

      <!-- Button to open a modal window -->
      <ModalTest v-if="show" @close="closeConfirm"></ModalTest>
      
      <button
        @click="openConfirm"
        class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-cringe_text bg-cringe_box hover:bg-cringe_front focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-boxhighlight"
      >
        Modal
      </button>
    
      <!-- Div for login box -->    
      <div class="bg-cringe_box py-8 px-4 sm:rounded-lg sm:px-10 space-y-6">

        <input
          v-model="userEmail"
          type="text"
          placeholder="Email"
          class="bg-cringe_box text-cringe_front placeholder-cringe_front border-cringe block w-full px-3 py-2 border-4 rounded-md shadow-sm focus:outline-none focus:ring-cringe_back focus:border-cringe_front sm:text-sm"
        />
§§
        <input
          v-model="userPass"
          type="password"
          placeholder="Password"
          class="bg-cringe_box text-cringe_front placeholder-cringe_front border-cringe block w-full px-3 py-2 border-4 rounded-md shadow-sm focus:outline-none focus:ring-cringe_back focus:border-cringe_front sm:text-sm"
        />

        <p class="text-boxtext2 text-xs italic">{{ msg }}</p>

        <button
          @click="login"
          class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-cringe_text bg-cringe hover:bg-cringe_front focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-boxhighlight"
        >
          Login
        </button>

      </div>

    </div>
  </div>
</template>

<style scoped></style>
