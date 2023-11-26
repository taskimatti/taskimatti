# Fuksipassi

Sähköinen fuksipassi

## Plan

````mermaid
graph LR
;
    User -->|Frontend| F(Vue3/Nuxt3);
    F -->|Backend| D(Django);
    D -->|CMS| C(Directus);
    C -->|Database| PostgreSQL;

````

### Frontend

````mermaid
graph TD
;
    Frontend{Frontend} -->|Framework| Nuxt3;
    Nuxt3 -->|Framework| Vue3;
    Nuxt3 -->|Language| TypeScript;
    Frontend -->|CSS| Tailwind;
````

### Backend

````mermaid
graph TD
;
    Frontend{Frontend} -->|Framework| Nuxt3;
    Nuxt3 -->|Framework| Vue3;
    Nuxt3 -->|Language| TypeScript;
    Frontend -->|CSS| Tailwind;
    Backend{Backend} -->|Language| Python;
    Backend{Backend} -->|Language| Go;
    Python -->|Framework| Django;
    Go -->|Framework| Gin;
    Go -->|Framework| ???;
````

