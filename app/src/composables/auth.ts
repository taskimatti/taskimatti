// auth.ts
import { useDirectus } from "./directus";

const fetchWithAuth = async (url: string, method: string, body: any) => {
  const response = await fetch(url, {
    method,
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(body),
  });

  if (!response.ok) {
    if (response.status === 400) {
      return await response.json();
    }

    if (response.status === 401) {
      throw new Error("Unauthenticated");
    }

    if (response.status === 403) {
      throw new Error("Unauthorized");
    }

    if (response.status === 404) {
      throw new Error("Not found");
    }

    if (response.status === 500) {
      throw new Error("Server error");
    }

    if (response.status === 502) {
      throw new Error("Bad gateway");
    }

    if (response.status === 503) {
      throw new Error("Service unavailable");
    }

    throw new Error(
      `HTTP error! status: ${response.status} ${response.statusText}`,
    );
  }

  // Check if the response is a 204 No Content response
  if (response.status === 204) {
    return {};
  }

  const data = await response.json();

  if (data.errors) {
    throw new Error(data.errors[0].message);
  }

  return data;
};

export const login = async (credentials: {
  email: string;
  password: string;
}) => {
  const { $directus } = useDirectus();
  const data = await fetchWithAuth(
    $directus.url.href + "auth/login",
    "POST",
    credentials,
  );
  if (data.errors) {
    return data.errors[0].message;
  }
  const { access_token, refresh_token } = data.data;
  localStorage.setItem("access_token", access_token);
  localStorage.setItem("refresh_token", refresh_token);
  return "success";
};

export const logout = async () => {
  const { $directus } = useDirectus();
  await fetchWithAuth($directus.url.href + "auth/logout", "POST", {
    refresh_token: localStorage.getItem("refresh_token"),
  });
  localStorage.removeItem("access_token");
  localStorage.removeItem("refresh_token");
  return "success";
};

export const refresh = async () => {
  const { $directus } = useDirectus();
  const data = await fetchWithAuth(
    $directus.url.href + "auth/refresh",
    "POST",
    { refresh_token: localStorage.getItem("refresh_token") },
  );
  if (data.errors) {
    return data.errors[0].message;
  }
  const { access_token, refresh_token } = data.data;
  localStorage.setItem("access_token", access_token);
  localStorage.setItem("refresh_token", refresh_token);
  return "success";
};
