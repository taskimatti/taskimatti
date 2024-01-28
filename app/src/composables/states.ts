import { useState } from 'nuxt/app';

export const useOrganisation = () =>
  useState<Organisation>('organisation', () => {
    return {
      id: undefined,
      name: undefined,
      description: undefined,
      image: undefined,
      color_scheme: undefined,
      status: undefined,
      date_created: undefined,
      user_updated: undefined,
      date_updated: undefined,
    };
  });
export const useProjects = () => useState<[Project] | null>('projects', () => null);

export const useProject = () =>
  useState<Project>('project', () => {
    return {
      id: undefined,
      status: undefined,
      user_created: undefined,
      date_created: undefined,
      user_updated: undefined,
      date_updated: undefined,
      name: undefined,
      description: undefined,
      colorScheme: undefined,
      units: undefined,
      image: undefined,
      users: undefined,
      scoreboard: undefined,
    };
  });

export const useUser = () =>
  useState<User>('user', () => {
    return {
      first_name: undefined,
      last_name: undefined,
      email: undefined,
      password: undefined,
      avatar: undefined,
      location: undefined,
      title: undefined,
      description: undefined,
      tags: undefined,
      preferences_divider: undefined,
      language: undefined,
      tfa_secret: undefined,
      email_notifications: undefined,
      theming_divider: undefined,
      appearance: undefined,
      theme_light: undefined,
      theme_light_overrides: undefined,
      theme_dark: undefined,
      theme_dark_overrides: undefined,
      admin_divider: undefined,
      status: undefined,
      role: undefined,
      token: undefined,
      id: undefined,
      last_page: undefined,
      last_access: undefined,
      provider: undefined,
      external_identifier: undefined,
      auth_data: undefined,
    };
  });

export const useRoles = () => useState<[Role] | null>('roles', () => null);

export const useAssets = () => useState<String | null>('assets', () => null);
