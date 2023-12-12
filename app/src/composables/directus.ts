// directus.ts
import { useNuxtApp } from '#app';

export const useDirectus = () => {
  const { $directus, $readItem, $readItems } = useNuxtApp();
  return { $directus, $readItem, $readItems };
};
