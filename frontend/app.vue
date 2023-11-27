<script setup lang="ts">
import {ref, provide} from 'vue';
import {useRouter} from 'vue-router';
import TopBar from "./components/nav/TopBar.vue";


import data_client from '~/data/client.data.json';
import data_organisations from '~/data/org.data.json';

const clientData = data_client.data
const org = ref(clientData.org);
const userId = ref(clientData.user);
const tasks = ref({});
const users = ref({});
const user = ref({});
const organisation = ref({});

const org_names = data_organisations.data.map((o) => o.org);

const route = useRouter()?.currentRoute?.value?.fullPath
const first = route.split("/")[1];

org.value = org_names.includes(first) ? first : org.value

const loadTasksAndUsers = async () => {

  try {
    const tasksData = await import(`~/data/${org.value}.tasks.json`);
    tasks.value = tasksData.data;

    const usersData = await import(`~/data/${org.value}.users.json`);
    users.value = usersData.data;

    user.value = users.value[userId.value];

  } catch (error) {
    console.error('Error loading data:', error);
  }
};

await loadTasksAndUsers();

organisation.value = data_organisations.data.find((o) => o.org === org.value);

provide('organisation', organisation.value);
provide('colorscheme', organisation.value.colorscheme);
provide('org', org.value);
provide('user', user.value);
provide('users', users.value);
provide('tasks', tasks.value);

</script>

<template>
  <TopBar/>
  <NavBar/>
  <router-view class="mt-16"/>
  <Footer/>
</template>
