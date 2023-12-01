// https://nuxt.com/docs/api/configuration/nuxt-config
import * as path from "path";

export default defineNuxtConfig({
  devtools: { enabled: true },
  css: ['~/assets/css/main.css'],
  postcss: {
    plugins: {
      tailwindcss: {},
      autoprefixer: {},
    },
  },
  alias: {
    '~' : path.resolve(__dirname),
  }
})