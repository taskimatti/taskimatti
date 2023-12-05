import { useState } from "nuxt/app";

export const useProjects = () =>
  useState<[Object]>("projects", () => [
    {
      id: "",
      name: "",
      description: "",
      status: "",
      created_at: "",
      updated_at: "",
    },
  ]);

export const useProject = () =>
  useState<{}>("project", () => ({
    id: "",
    status: "",
    user_created: "",
    date_created: "",
    user_updated: "",
    date_updated: "",
    name: "",
    description: "",
    colorScheme: "",
    units: "",
    image: "",
  }));

export const useUser = () =>
  useState<{}>("user", () => ({
    id: "",
    name: "",
    email: "",
    email_verified_at: "",
    created_at: "",
    updated_at: "",
  }));

export const useRoles = () =>
  useState<[Object]>("roles", () => [
    {
      id: "",
      name: "",
      guard_name: "",
      created_at: "",
      updated_at: "",
    },
  ]);

export const useAssets = () => useState<String>("assets", () => "");
