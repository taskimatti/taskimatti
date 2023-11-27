# Fuksipassi

![Fuksipassi logo](assets/f-logo-no-bg.svg)

##### Digitaalinen suoritusten seuranta-alusta



### Taustaa

Perinteisessä fuksipassissa, ensimmäisen vuoden opiskelijat suorittavat tuutorien laatimia tehtäviä.

Vain tuutorit voivat merkata tehtävän suoritetuksi.

Fuksit kilpailevat keräämällä pisteitä suorituksista.


### Digitaalinen ratkaisu

- Helpottaa fuksipassin tekoa
    - Ei tarvetta paperin painatukselle
    - Muokattavat tehtävänannot
- Realiaikainen pisteidenseuranta
    - Scoreboard
    - Kilpailua!
- Parantaa kokemusta
    - Suorituksia ei voida väärentää
    - Kulkee aina mukana
    - Ei hajoa käytössä


#### Käyttäjätasot
 
![user hierarchy](assets/userlevels.png)


### Käyttökohteet

VSCodiumia voidaan käyttää samalla tavalla kuin VSCodea, eli koodieditorina ja kehitysympäristönä eri ohjelmointikielille ja alustoille. 

VSCodiumin vahvuus on sen monipuolisuus ohjelmistotuotannossa.

Siihen voi asentaa lisäosilla esimerkiksi syntaksinväritys- ja debuggaustuen ohjelmointikielille, jota se ei ennestään tue.


## Lisenssi


### Visual Studio Coden lisenssi

- Lähdekoodilla [MIT-lisenssi](https://github.com/VSCodium/vscodium/blob/master/LICENSE)
- Microsoftin jakaman ohjelmatiedoston (.exe, .app jne.) [lisenssi](https://code.visualstudio.com/License/) ei ole avoin.


### Visual Studio Codiumin lisenssi

- VSCodiumin lähdekoodilla ja ohjelmatiedostoilla (binääri) on [MIT-lisenssi](https://github.com/VSCodium/vscodium/blob/master/LICENSE)
  - Microsoftin Visual Studio Marketplacesta hankittujen lisäosien käyttö VSCodiumissa rikkoo periaatteessa lisenssiä
  - Jotkin Microsoftin kehittämistä laajennuksista (esim. C#- ja C++\-lisäosien debuggeri) eivät toimi kuin VSCodessa.



## Aktiivisuus ja ylläpito


### Historia

- Visual Studio Coden ensimmäinen versio julkaistiin 29.4.2015 
- Lähdekoodi saataville GitHubiin 18.11.2015
- VSCodiumin ensimmäinen julkaisu 15.8.2018


### Aktiivisuus

- Päivityksiä tulee suunnilleen viikoittain. Viimeisin julkaistu versio 1.83.0.23283 julkaistiin 10.11.2023.
- Microsoftin julkaistessa päivityksen Visual Studio Codeen VSCodiumin GitHub-repossa oleva skripti kloonaa VSCoden repon, kääntää ohjelman ja lataa tuotetut ohjelmatiedostot GitHubiin


### Ylläpito

VSCodiumia ylläpitää yhteisö vapaaehtoisia kehittäjiä, jotka ovat listattuina projektin GitHub-sivulla.



## Osallistuminen projektiin


VSCodium-projekti noudattaa avointa ja yhteisöllistä osallistumismallia, jossa kuka tahansa voi ehdottaa muutoksia tai parannuksia projektin lähdekoodiin tai dokumentaatioon.


### Osallistumisen Menettelytavat

Jos haluat osallistua projektiin sinun täytyy kloonata ensin VSCodium-repositorio omalle tietokoneellesi. Sitten voit tehdä haluamasi muutokset projektin lähdekoodiin.

Kun muutokset ovat valmiit, voit lähettää pull-requestin jossa kuvailet tekemäsi muutokset ja pyydät niiden hyväksymistä master branchiin. 

Jos muutoksesi hyväksytään, ne lisätään osaksi VSCodium projektia.



## Tekninen toteutus


### Kielet

- TypeScript, JavaScript, HTML, CSS
- Joitakin Rust-tiedostoja
- VSCodiumin repossa shell-skriptejä ja yksi XSLT-tiedosto


### Protokollat

Language Server Protocol, [Microsoftin](https://microsoft.github.io/language-server-protocol/) alunperin VS Codea varten kehittämä protokolla, jonka on tarkoitus helpottaa esim. syntaksivärityksen kaltaisten ominaisuuksien kehittämistä eri kielille


### Välineet

- Electron, ohjelmistokehys työpöytäsovellusten tekoon käyttäen HTML:a, CSS:ä ja JavaScriptiä
- Chromium, verkkoselain
- Node.js, JavaScript-palvelin



## Asennus ja käyttöönotto


VSCodiumin voi kääntää Microsoftin Visual Studio Code Reposta myös halutessaan itse ([Microsoftin ohje](https://github.com/Microsoft/vscode/wiki/How-to-Contribute#build-and-run)). Se ei ole kuitenkaan tarpeellista.


### GNU/Linux


### Asentaminen snapilla

VSCodium löytyy [Snap Store](https://snapcraft.io/)sta [Codium](https://snapcraft.io/codium) nimellä. Jos GNU/Linux jakelusi tukee snap:iä:

```snap install codium --classic```


### Asentaminen Parrot OSlla 

VSCodium on valmiiksi asennettuna [Parrot OS](https://www.parrotsec.org/)ssa. Jos sitä ei jostain syystä ole valmiina, niin voit löytää sen virallisesta reposta:

```sudo apt update && sudo apt install codium```


### Asentaminen NixOSlla

VSCodium löytyy Nixpkgsistä. Voit asentaa sen lisäämällä ```vscodium```  ```environment.systemPackages```iin ```configuration.nix```iin tai lokaalisti:

```nix-env -iA nixpkgs.vscodium```


### Asemtaminen Arch Linuxilla

VSCodium on saatavilla [AUR](https://aur.archlinux.org/packages/vscodium-bin)issa (Arch User Reposity) ja sen voi asentaa AUR Helperillä.

#### Aura:

```sudo aura -A vscodium-bin```
#### Yay:

```yay -S vscodium-bin```


### Asentaminen Debianilla/Ubuntulla

Lisää GPG avain repoon:

``````
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
``````

Lisää repo:
``````
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list
``````


Päivitä ja asenna VSCodium:

```sudo apt update && sudo apt install codium```


### Asentaminen Fedoralla / RHELilla / CentOSilla / RockyLinuxilla / OpenSUSElla (rpm paketti)

Lisää GPG avain repoon:

```sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg```


Lisää repo:

- Fedora/RHEL/CentOS/Rocky Linux:

    ```printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo```

- OpenSUSE/SUSE:

    ```printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/zypp/repos.d/vscodium.repo```


Asenna ohjelma: 

- Fedora/RHEL/CentOS/Rocky Linux:

    ```sudo dnf install codium```

- OpenSUSE/SUSE:

    ```sudo dnf install codium```


### Install on Gentopo / Funtoo Linux (ebuild)

- Gentoo: 

     ```sudo emerge -av vscodium-bin```

- Funtoo:

    ```sudo emerge -av vscodium```


### Flatpak

VSCodium (epävirallisesti) saatavilla [FLatpak](https://flathub.org/apps/com.vscodium.codium) sovelluksena ([repo](https://github.com/flathub/com.vscodium.codium)). Jos jakelusi tukee flatpakkiä ja käytät [flathub repoa](https://flatpak.org/setup/) niin voit asentaa VSCodiumin komentoriviltä:

```flatpak install flathub com.vscodium.codium```

tai avaamalla [flatpakref](https://dl.flathub.org/repo/appstream/com.vscodium.codium.flatpakref)in Flathubista. VSCodium löytyy myös GNOME Softwaresta jos sinulla on ```gnome-software-plugin-flatpak``` asennettuna.


### Mac


#### Asentaminen Brewillä

```brew install --cask vscodium```

Jos käytät Mac OS C Mojativeä ja näet tekstin *App can't be opened because Apple cannot check it for malicous software*, kun avaat VSCodiumin ensimmäistä kertaa, niin klikkaa hiiren oikeaa näppäintä ja valitse *Open*. Tämän pitäisi olla välttämätöntä vain Mojave käyttäjillä!


### Windows


#### Asentaminen Windows Package Managerilla:

```winget install vscodium```

#### Asentaminen Chocolateylla:

```choco install vscodium```

#### Asentaminen Scoopilla:

```scoop bucket add extras```

```scoop install vscodium```



## Lähteet


Verkkolähteissä vierailtu 13.10.2023.

- [VSCodiumin GitHub-sivu](https://github.com/VSCodium/vscodium/) 
- [VSCodiumin kotisivu](https://vscodium.com/)
- Microsoftin [Visual Studio Coden kotisivu](https://code.visualstudio.com/) ja dokumentaatio
