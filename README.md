# 🅤🅡🅑🅐🅝🅓🅡🅘🅥🅔
# Hurtownia Danych dla (wymyślonej) firmy CarSharing UrbanDrive
Projekt realizowany ramach laboratorium z Hurtowni Danych (Politechnika Gdańska, kierunek Informatyka)  

  
## ETL Process
Proces ETL przebeiga dizęki utworzonym plikom TSQL, w odpowiedniej kolejności ładowanym przez SSIS do kostki (CUBE) utworzonej wcześniej w projekcie /Implementation  
1. **Snapshot1** inserting in UrbanDrive DB
2. Initial data needs to be uploaded by **executing SQL files in SSMS**
3. Regular data from dimensions are uploaded by **SSIS ETL processing**
4. Data from Facts is uploaded are **SSIS ETL processing**
5. Processing the **CUBE**
6. **Drop** of UrbanDrive DB and data from **Snapshot2** insert
7. Regular dimensions and Facts upload by SSIS ETL processing (**SCD2** User dimension chandling in TSQL load file)
8. Processing the **CUBE**

| 2. Initial | 3. Data | 4. Facts |
| ---------- | ----------------- | -------------------------- |
| `load inne`  | `load samochody`    | `load wypozyczenia`          |
| `load daty`  | `load uzytkownicy`  | `load zgloszenia wypozyczen` |
| `load czasy` | `load miejsca`      |                            |
|              | `load zloszenia`    |                            |
