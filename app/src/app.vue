<script setup lang="ts">
import { ref } from "vue";
import { useRoute } from "vue-router";
import TopBar from "./components/nav/TopBar.vue";
import { readMe, readRoles } from "@directus/sdk";
import { useAssets, useProject, useProjects, useRoles, useUser } from "./composables/states";

const { $directus, $readItems } = useNuxtApp();
const route = useRoute();

const uuid = ref(route?.params?.project?.toString());

const projects = useProjects();
const project = useProject();
const user = useUser();
const roles = useRoles();
const assets = useAssets();

const { data: _projects } = await useAsyncData(() => {
  return $directus.request($readItems("Project"));
});

const { data: _user } = await useAsyncData(() => {
  return $directus.request(readMe({ fields: ["role"] }));
});

const { data: _roles } = await useAsyncData(() => {
  return $directus.request(readRoles({ fields: ["id", "name", "admin_access"] }));
});

projects.value = _projects;
user.value = _user;
roles.value = _roles;

if (uuid.value) {
  project.value = projects.value.find((project) => project.id === uuid.value);
}

assets.value = $directus.url.href + "assets/";
</script>

<template>
  <div class="min-h-screen bg-gray-900">
    <TopBar />
    <div class="container">
      <div class="min-h-[50vh]">
        <router-view />
      </div>
    </div>
    <NavBar />
  </div>
</template>
