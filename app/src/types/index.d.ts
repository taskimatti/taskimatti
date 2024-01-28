export { Project, Task, Organisation, User, Role };

declare global {
  interface Organisation {
    id: string | undefined;
    name: string | undefined;
    description: string | undefined;
    image: string | undefined;
    color_scheme: string | undefined;
    status: string | undefined;
    date_created: string | undefined;
    user_updated: string | undefined;
    date_updated: string | undefined;
  }
  interface Project {
    id: string | undefined;
    status: string | undefined;
    user_created: string | undefined;
    date_created: string | undefined;
    user_updated: string | undefined;
    date_updated: string | undefined;
    name: string | undefined;
    description: string | undefined;
    colorScheme: string | undefined;
    units: string | undefined;
    image: string | undefined;
    users: Project_directus_users[] | undefined;
    scoreboard: boolean | undefined;
  }
  interface Project_directus_users {
    id: string | undefined;
    Project_id: string | undefined;
    directus_users_id: string | undefined;
    role: Role;
  }
  interface Task {
    id: string | undefined;
    status: string | undefined;
    project: string | undefined;
    title: string | undefined;
    points: string | undefined;
    desc: string | undefined;
    type: string | undefined;
    image: string | undefined;
    key: string | undefined;
    users: User[] | undefined;
    completed?: boolean;
    sort: string | undefined;
    user_created: string | undefined;
    date_created: string | undefined;
    user_updated: string | undefined;
    date_updated: string | undefined;
  }

  interface User {
    first_name: string | undefined;
    last_name: string | undefined;
    email: string | undefined;
    password: string | undefined;
    avatar: string | undefined;
    location: string | undefined;
    title: string | undefined;
    description: string | undefined;
    tags: string[] | undefined;
    preferences_divider: string | undefined;
    language: string | undefined;
    tfa_secret: string | undefined;
    email_notifications: boolean | undefined;
    theming_divider: string | undefined;
    appearance: string | undefined;
    theme_light: string | undefined;
    theme_light_overrides: string | undefined;
    theme_dark: string | undefined;
    theme_dark_overrides: string | undefined;
    admin_divider: string | undefined;
    status: string | undefined;
    role: string | undefined;
    token: string | undefined;
    id: string | undefined;
    last_page: string | undefined;
    last_access: string | undefined;
    provider: string | undefined;
    external_identifier: string | undefined;
    auth_data: string | undefined;
  }
  interface Role {
    id: string | undefined;
    name: string | undefined;
    icon: string | undefined;
    description: string | undefined;
    app_access: boolean | undefined;
    admin_access: boolean | undefined;
    ip_access: string[] | undefined;
    enforce_tfa: boolean | undefined;
    users: User[] | undefined;
  }
}
