import { createDirectus, rest, readItem, readItems, authentication } from "@directus/sdk";

async function setupDirectus(url: string, email: string, password: string) {
  const directus = createDirectus(url).with(authentication()).with(rest());
  return { directus, readItem, readItems };
}

export default defineNuxtPlugin(async () => {
  const config = useRuntimeConfig();
  const { directus, readItem, readItems } = await setupDirectus(
    config.public.API_URL,
  );
  return {
    provide: { directus, readItem, readItems },
  };
});
