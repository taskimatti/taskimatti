<script setup lang="ts">
import { inject } from 'vue';

const user = inject('user')
const admin = user.isAdmin
</script>


<template>
  <div v-if="admin">
    <h1 class="text-center">Olet Admin</h1>
  </div>
</template>

<style scoped></style>
