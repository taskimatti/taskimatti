<script>

import { createDirectus, authentication, rest, login } from '@directus/sdk';

export default {
  data() {
    return {

      userEmail: null,
      userPass: null
    }
  },
  methods: {
    async login() {
      const client = createDirectus('https://cms.uwu.jeb4.dev').with(authentication()).with(rest()); 

      this.userEmail = emailInput;
      this.userPass = passwordInput;

      if(this.userEmail && this.userPass){
        const result = await client.login(this.userEmail, this.userPass);
      }
    /* async sendCredentials() {
       const response =
         await fetch('https://cms.uwu.jeb4.dev/auth/authenticate', {
           method: 'POST',
           headers: {
             'Content-Type': 'application/json'
           },
           body: JSON.stringify({
             email: this.emailInput,
             password: this.passwordInput
           })
         });
       if (response.ok) {
         const data = await response.json();
         // Store the user token in local storage or a cookie
         localStorage.setItem('userToken', data.token);
       } else {
         throw new Error('Login failed');
       }
       const data = await response.json();
       // console.log("Response from Directus:", data);
     },*/

    
        
/*
      const client = createDirectus('https://cms.uwu.jeb4.dev').with(authentication()).with(rest());
      // login using the authentication composable
      const result = await client.login(emailInput, passwordInput);
      // login http request
*/
      

      /*directus.auth.login({
        email: this.emailInput,
        password: this.passwordInput
      }).then(response => {
        const token = response.data.access_token;
        // Use the token to authenticate within Directus
      }).catch(error => {
        console.error(error);
      });*/
    }
  }
}

</script>
<template>
  <div class="flex flex-col justify-center py-12 sm:px-6 lg:px-8">
    <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
      <div class="bg-gray-800 py-8 px-4 sm:rounded-lg sm:px-10">
        <form class="space-y-6" action="#" method="POST" v-on:submit.prevent="login">
          <div>
            <label for="email" class="block text-sm font-medium text-white">
              Email
            </label>
            <div class="mt-1">
              <input v-model="emailInput" id="email" name="email" type="text" autocomplete="email" required
                class=" text-black block w-full px-3 py-2 border-4 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" />

            </div>

          </div>
          <div>
            <label for="password" class="block text-dsm font-medium text-white">
              Password
            </label>
            <div class="mt-1">
              <input v-model="passwordInput" id="password" name="password" type="password" autocomplete="current-password"
                required
                class=" text-black block w-full px-3 py-2 border-4 rounded-md shadow-sm  focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" />
            </div>
          </div>
          <div>
            <button type="submit"
              class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
              Login
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>
  
<style scoped></style>