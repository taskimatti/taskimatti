<script setup lang="ts">
import data from "~/data/user.data.json";
import users from "~/data/users.json";

import type DefaultUserData from "~/types";
import type DefaultUser from "~/types";

const currentUser: DefaultUserData = data.data;
const user: DefaultUser = users.data.find((user) => user.id === currentUser.id);

const admin = user.isAdmin
</script>


<template>
  <div v-if="admin">
    <h1 class="text-center">Olet Admin</h1>
  </div>
</template>

<style scoped></style>
