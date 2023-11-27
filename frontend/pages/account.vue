<script setup lang="ts">
// get the user data from the json file
import data from "~/data/user.data.json";
import users from "~/data/users.json";

// import the type of the user data
import type DefaultUserData from "~/types";
import type DefaultUser from "~/types";

const userData: DefaultUserData = data.data;
const user: DefaultUser = users.data.find((user) => user.id === userData.id);
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