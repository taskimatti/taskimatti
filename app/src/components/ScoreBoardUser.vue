<script setup lang="ts">
import { ref } from "vue";
import { useAssets } from "../composables/states";

const assets = ref({});

const updatePage = async () => {
  assets.value = useAssets();
};

await updatePage();
</script>
<script lang="ts">
export default {
  props: {
    user: {
      type: Object,
      required: true,
    },
    unit: {
      type: String,
      required: true,
    },
  },
};
</script>

<template>
  <div class="flex items-center justify-between p-2 gap-3">
    <div class="flex items-center gap-4">
      <p class="text-2xl font-bold text-gray-200">{{ user.rank }}.</p>
      <NuxtImg
        :src="user.avatar ? assets.value + user.avatar : '/images/avatar.jpg'"
        class="w-16 h-16 rounded-full object-cover"
        width="64"
        height="64"
        quality="10"
        placeholder="/images/avatar.jpg"
      />
      <div>
        <p class="text-2xl font-bold">{{ user.first_name }}</p>
      </div>
    </div>
    <p class="text-xl font-medium text-gray-200">{{ user.score }} {{ unit }}</p>
  </div>
</template>

<style scoped></style>
