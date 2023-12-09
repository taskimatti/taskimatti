// auth.ts
import { useDirectus } from "./directus";

export const login = async (email: string, password: string) => {
  const { $directus } = useDirectus();
  return await $directus.login(email, password);
};

export const logout = async () => {
  const { $directus } = useDirectus();
  await $directus.logout();
};
