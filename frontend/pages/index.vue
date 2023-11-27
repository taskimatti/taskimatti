<script setup lang="ts">
import type DefaultTask from "~/types";
import data from "~/data/tasks.json";

const tasks: DefaultTask[] = data.data;
</script>

<template>
  <div class="flex justify-center mx-8 mt-16">
    <div>
      <ol>
        <li v-for="task in tasks">
          <Task :task="task" />
        </li>
      </ol>
    </div>
  </div>
</template>

<style scoped></style>
