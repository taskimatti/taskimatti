import {
  createDirectus,
  rest,
  readItem,
  readItems,
  authentication,
} from "@directus/sdk";
import { config } from 'dotenv'
config()

async function setupDirectus() {
  const directus = createDirectus(process.env.API_URL)
    .with(authentication())
    .with(rest());
  await directus.login(process.env.API_EMAIL, process.env.API_PASSWD);
  return { directus, readItem, readItems };
}

export default defineNuxtPlugin(async () => {
  const { directus, readItem, readItems } = await setupDirectus();
  return {
    provide: { directus, readItem, readItems },
  };
});
