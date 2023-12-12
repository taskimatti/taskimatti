import { authentication, createDirectus, readItem, readItems, rest } from '@directus/sdk';

async function setupDirectus(url: string) {
  const directus = createDirectus(url).with(authentication()).with(rest());
  return { directus, readItem, readItems };
}

export default defineNuxtPlugin(async () => {
  const config = useRuntimeConfig();
  const { directus, readItem, readItems } = await setupDirectus(config.public.API_URL);
  return {
    provide: { directus, readItem, readItems },
  };
});
