<script setup lang="ts">
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
    required: true,
  },
});
</script>

<template>
  <div class="bg-gray-800 p-6 rounded-lg shadow-md w-full">
    <NuxtImg
      :src="image.endsWith('null') ? '/images/avatar.jpg' : image"
      placeholder="/images/avatar.jpg"
      alt="Avatar"
      width="100"
      height="100"
      class="h-32 w-32 object-cover rounded-full border-2 border-gray-600"
    />
    <h2 class="text-2xl text-white mt-4">{{ user.first_name }}</h2>
    <p class="text-gray-400">{{ role }}</p>
  </div>
</template>

<style scoped></style>
