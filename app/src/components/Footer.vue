<script setup lang="ts">
let sha = "null";
await fetch("https://api.github.com/repos/serveri/fuksipassi/commits/main")
  .then((response) => response.json())
  .then((data) => {
    sha = data.sha;
  })
  .catch((error) => {
    console.error(error);
    sha = "error";
  });

if (sha == undefined) sha = "error";
</script>

<template>
  <div class="flex justify-center mt-8 mb-2">
    <div>
      <p>Fuksipassi 2023</p>
      <p>
        Version
        <a class="underline" href="https://github.com/serveri/fuksipassi/tree/main"> {{ sha?.slice(0, 7) }}</a>
      </p>

      <dev-only class="text-green-700">Mode <span class="text-green-700">DEV</span></dev-only>
      <p>
        Build and maintained by
        <a class="underline" href="https://github.com/serveri">Fuksipassi</a>
      </p>
    </div>
  </div>
</template>

<style scoped></style>
