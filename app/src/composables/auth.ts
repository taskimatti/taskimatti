// auth.ts
import { useDirectus } from "./directus";

export const login = async (email: string, password: string) => {
  const { $directus } = useDirectus();
  try {
    await $directus.login(email, password);
  } catch (error) {
    return error;
  }
  return $directus;
};

export const logout = async () => {
  const { $directus } = useDirectus();
  await $directus.logout();
};
