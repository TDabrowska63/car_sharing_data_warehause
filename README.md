# 🅤🅡🅑🅐🅝🅓🅡🅘🅥🅔
# Hurtownia Danych dla (wymyślonej) firmy CarSharing UrbanDrive
Projekt realizowany ramach laboratorium z Hurtowni Danych (Politechnika Gdańska, kierunek Informatyka)  

  
## ETL Process
Proces ETL przebeiga dizęki utworzonym plikom TSQL, w odpowiedniej kolejności ładowanym przez SSIS do kostki (CUBE) utworzonej wcześniej w projekcie /Implementation
| 1. Initial | 2. Data | 3. Facts | 4. Process the CUBE | 5. SCD2?? |
| ---------- | ----------------- | -------------------------- | - | - |
| load inne  | load samochody    | load wypozyczenia          |   |   |
| load daty  | load uzytkownicy  | load zgloszenia wypozyczen |   |   |
| load czasy | load miejsca      |                            |   |   |
|            | load zloszenia    |                            |   |   |
