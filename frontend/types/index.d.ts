export { DefaultTask, DefaultUser, DefaultUserData };

declare global {
  interface DefaultTask {
    id: number;
    name: string;
    desc: string;
    points: number;
    status: boolean;
  }

  interface DefaultUser {
    isAdmin: boolean;
    id: number;
    name: string;
    points: number;
  }

  interface DefaultUserData {
    id: number;
  }
}
