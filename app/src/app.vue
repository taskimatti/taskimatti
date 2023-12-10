<script setup lang="ts">
import { ref } from "vue";
import { useRoute } from "vue-router";
import { readMe, readRoles } from "@directus/sdk";
import { useAssets, useProject, useProjects, useRoles, useUser } from "./composables/states";
import { useDirectus } from "./composables/directus";
import { refresh } from "./composables/auth";
import TopBar from "~/components/nav/TopBar.vue";
import NavBar from "~/components/nav/NavBar.vue";

const { $directus, $readItems } = useDirectus();

if (process.client) {
  const token = window.localStorage.getItem("access_token");
  if (token) {
    $directus.setToken(token);
    // Refresh the token
    if (window.location.pathname !== "/login") {
      if (window.localStorage.getItem("refresh_token")) {
        const response = await refresh();
        if (response === 401) {
          window.location.href = "/login";
        }
      }
    }
  } else {
    if (window.location.pathname !== "/login") window.location.href = "/login";
  }
}

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
