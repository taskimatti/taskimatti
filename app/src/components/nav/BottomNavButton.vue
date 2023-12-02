<script setup lang="ts"></script>
<script lang="ts">
export default {
  props: {
    text: {
      type: String,
    },
    href: {
      type: String,
    },
  },
};
</script>
<template>
  <div>
    <div class="p-4 h-full w-full flex justify-center items-center">
      <nuxt-link
        :to="'/' + href"
        :class="[
          $route.path === '/' + href
            ? 'text-white'
            : 'text-gray-700 dark:text-gray-300 hover:underline hover:text-white',
          'text-sm',
        ]"
        >{{ text }}
      </nuxt-link>
    </div>
  </div>
</template>

<style scoped></style>
