# Digital Task-Tracking Platform

![Vue](https://img.shields.io/badge/-Vue_3-4FC08D?style=flat-square&logo=vue.js&logoColor=white)
![Nuxt](https://img.shields.io/badge/-Nuxt_3-00C58E?style=flat-square&logo=nuxt.js&logoColor=white)
![Directus](https://img.shields.io/badge/-Directus-2586B3?style=flat-square&logo=directus&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/-PostgreSQL-336791?style=flat-square&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/-Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

![GitHub last commit](https://img.shields.io/github/last-commit/serveri/fuksipassi)
![GitHub issues](https://img.shields.io/github/issues/serveri/fuksipassi)
![GitHub pull requests](https://img.shields.io/github/issues-pr/serveri/fuksipassi)

![GitHub top language](https://img.shields.io/github/languages/top/serveri/fuksipassi)
![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat)

![GitHub followers](https://img.shields.io/github/followers/serveri?style=social)
![GitHub forks](https://img.shields.io/github/forks/serveri/fuksipassi?style=social)
![GitHub Repo stars](https://img.shields.io/github/stars/serveri/fuksipassi?style=social)


## Plan

````mermaid
graph LR
;
    User -->|Frontend| F(Vue3/Nuxt3);
    F -->|CMS| C(Directus);
    C -->|Database| PostgreSQL;

````

### Traffic

````mermaid
graph TD
;
    Frontend{Frontend} -->|Framework| Nuxt3;
    Nuxt3 -->|CMS| Directus{Directus};
    Directus -->|Database| PostgreSQL;
    Directus <--> |API| Frontend;
    User{User} --> Frontend
    User{User} --> Directus
````


