
### Käyttäjätasot

#### Sähköinen passi (vas.) sähköinen fuksipassi (oik.)
````mermaid
graph TD
;
    Organisation{Organisaatio} --> Admin;
    Admin -->Moderaattori;
    Moderaattori --> Jäsen

    Ainejärjestö{Ainejärjestö} --> Vastuuhenkilö;
    Vastuuhenkilö --> Tuutori
    Tuutori --> Fuksi

````

