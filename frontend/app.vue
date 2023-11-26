<script setup lang="ts">
import DefaultTask from "~/types";
import data from "~/data/tasks.json";
const tasks: DefaultTask[] = data.data;
</script>
<template>
  <NavBar />
  <div class="flex justify-center m-6">
    <div>
      <ol>
        <li v-for="task in tasks">
          <Task :task="task" />
        </li>
      </ol>
    </div>
  </div>
  <Footer />
</template>
