<script setup lang="ts">
import DefaultTask from "~/types";
import data from "~/data/tasks.json";
const tasks: DefaultTask[] = data.data;
let score;

// calculate sum of scores where status is true
score = tasks
  .filter((task) => task.status)
  .map((task) => task.points)
  .reduce((a, b) => a + b, 0);
</script>
<template>
  <TopBar :score="score" />
  <NavBar />
  <div class="flex justify-center mx-8 mt-16">
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
