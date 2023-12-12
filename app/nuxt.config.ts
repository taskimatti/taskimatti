// https://nuxt.com/docs/api/configuration/nuxt-config
import { defineNuxtConfig } from "nuxt/config";
import * as path from "path";

export default defineNuxtConfig({
  routeRules: {
    '/login': { ssr: true },
    '/:project/**': { ssr: false },
    '/:project': { ssr: false }
  },
  app: {
    pageTransition: {
      mode: "out-in",
    },
  },
  modules: ["@nuxt/image"],
  srcDir: "src/",
  devtools: { enabled: true },
  css: ["~/assets/css/main.css"],
  postcss: {
    plugins: {
      tailwindcss: {},
      autoprefixer: {},
    },
  },
  alias: {
    "~": path.resolve(__dirname) + "/src",
  },
  runtimeConfig: {
    public: {
      API_URL: process.env.NUXT_API_URL || "http://localhost:8081",
      API_EMAIL: process.env.NUXT_API_EMAIL || "admin@example.com",
      API_PASSWD: process.env.NUXT_API_PASSWD || "secret",
    },
  },
});
