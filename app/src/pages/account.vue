<script setup lang="ts">
import { inject } from "vue";

const user = inject("user");
</script>

<template>
  <div>
    <div class="flex justify-center items-center flex-col">
      <div>
        <table class="table-auto">
          <tr>
            <th>Nimi</th>
            <th>Pisteet</th>
            <th>Admin</th>
          </tr>
          <tr>
            <td>{{ user.name }}</td>
            <td>{{ user.points }}</td>
            <td>{{ user.isAdmin }}</td>
          </tr>
        </table>
      </div>
    </div>
  </div>
</template>

<style scoped></style>
