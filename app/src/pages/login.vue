<script>
import { createDirectus, authentication, rest, login } from "@directus/sdk";

export default {
  data() {
    return {
      userEmail: "",
      userPass: "",
    };
  },
  methods: {
    async login() {
      console.log("Fetch");
      const client = createDirectus("https://cms.uwu.jeb4.dev").with(authentication()).with(rest());
      const result = await client.login(this.userEmail, this.userPass);
      console.log(result);

      localStorage.setItem('token', result.access_token);
      
      //const token = localStorage.getItem("token");
    },
  },
};
</script>
<template>
  <div class="flex flex-col justify-center py-12 sm:px-6 lg:px-8">
    <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
     
         <img
        src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDMiIGhlaWdodD0iNjMiIHZpZXdCb3g9IjAgMCA0MyA2MyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTM1LjYxNyAySDJWMjUuNDA0M00zNS42MTcgMkw0MS4zNjE3IDguMzgyOThWMTguMzgzTTM1LjYxNyAyVjEwLjI5NzlNNDEuMzYxNyAxOC4zODNMMzUuNjE3IDEwLjI5NzlNNDEuMzYxNyAxOC4zODNIMTcuMTA2NE0zNS42MTcgMTAuMjk3OUgxNy4xMDY0VjE4LjM4M00xNy4xMDY0IDE4LjM4M0wxNy4zMTkxIDI1LjUxMDZNMTcuMTA2NCA0Mi4yNlY2MS4xNDg5SDJWMjUuNDA0M00xNy4xMDY0IDQyLjI2SDM5LjMzMzhNMTcuMTA2NCA0Mi4yNlYzNC45Nzg3SDMzLjA2MzhNMzkuMzMzOCA0Mi4yNkwzMy4wNjM4IDM0Ljk3ODdNMzkuMzMzOCA0Mi4yNlYzMS4zNjE3TDMzLjA2MzggMjUuNDA0M00zMy4wNjM4IDM0Ljk3ODdWMjUuNDA0M00zMy4wNjM4IDI1LjQwNDNMMTcuMzE5MSAyNS41MTA2TTIgMjUuNDA0M0wxNy4zMTkxIDI1LjUxMDYiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iMi41NTMxOSIvPgo8L3N2Zz4K"
        alt="TaskiMatti logo"
        class=" h-full w-56 rounded-3xl p-12 mx-auto my-5 bg-white "
      />
      
     
      <div class="bg-gray-800 py-8 px-4 sm:rounded-lg sm:px-10">
        <form class="space-y-6" action="#" method="POST" v-on:submit.prevent="login">
          <div>
            <label for="email" class="block text-sm font-medium text-white"> Email </label>
            <div class="mt-1">
              <input
                v-model="userEmail"
                id="email"
                name="email"
                type="text"
                autocomplete="email"
                required
                class="text-black block w-full px-3 py-2 border-4 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm "
              />
            </div>
          </div>
          <div>
            <label for="password" class="block text-dsm font-medium text-white"> Password </label>
            <div class="mt-1">
              <input
                v-model="userPass"
                id="password"
                name="password"
                type="password"
                autocomplete="current-password"
                required
                class="text-black block w-full px-3 py-2 border-4 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
              />
            </div>
          </div>
          <div>
            <button
              type="submit"
              class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 "
            >
              Login
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<style scoped></style>
