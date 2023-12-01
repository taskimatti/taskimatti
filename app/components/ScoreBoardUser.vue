<script setup lang="ts"></script>
<script lang="ts">
import type DefaultUser from "~/types";

export default {
  props: {
    user: {
      type: Object as () => DefaultUser,
      required: true,
    },
  },
};
</script>

<template>
  <div class="flex justify-between p-2 gap-3">
    <p>{{ user.name }}</p>
    <p>{{ user.points }} bits</p>
  </div>
</template>

<style scoped></style>
