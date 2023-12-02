<script setup lang="ts">
const { $directus, $readItems } = useNuxtApp();

const { data: Organisation } = await useAsyncData("Organisation", () => {
  return $directus.request($readItems("Organisation"));
});
</script>

<template>
  <div>
    <div
      class="flex flex-row items-center justify-between p-2"
      :style="'background: ' + Organisation.color_scheme + ';'"
    >
      <NuxtImg
        :src="$directus.url.href + 'assets/' + Organisation.image"
        class="m-2 w-16 h-16 rounded-full object-cover"
        width="64"
        height="64"
        quality="10"
        placeholder
      />
      <div class="flex">
        <h1 class="text-3xl text-white">{{ Organisation.name }}</h1>
        <dev-only><p class="text-green-700">DEV</p></dev-only>
      </div>
      <p>{{ 12 }} {{ Organisation.point_units }}</p>
    </div>
  </div>
</template>

<style scoped></style>
