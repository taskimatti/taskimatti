<script setup lang="ts">
import TopBar from "./components/nav/TopBar.vue";
</script>
<template>
  <TopBar/>
  <NavBar />
  <router-view class="mt-16"/>
  <Footer />
</template>
