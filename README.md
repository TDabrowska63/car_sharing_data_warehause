# 🅤🅡🅑🅐🅝🅓🅡🅘🅥🅔
# Data Warehouse for the (imaginary) company CarSharing UrbanDrive
Project implemented as part of the Data Warehouse laboratory (Gdańsk University of Technology, Computer Science major)

  
## ETL Process
The ETL process runs thanks to the created SQL files, loaded in the appropriate order by SSIS into the cube (CUBE) created earlier in the /Implementation project  
1. **Snapshot1** inserting in UrbanDrive DB
2. Initial data needs to be uploaded by **executing SQL files in SSMS**
3. Regular data from dimensions are uploaded by **SSIS ETL processing**
4. Data from Facts is uploaded are **SSIS ETL processing**
5. Processing the **CUBE**
6. **Drop** of UrbanDrive DB and data from **Snapshot2** insert
7. **Changing the date** when 3 years have passed since obtaining a driving license (because now its t2 time) in **TSQL load uzytkownicy file**
8. Regular dimensions and Facts upload by SSIS ETL processing (**SCD2** User dimension chandling in TSQL load file)
9. Processing the **CUBE**

| 2. Initial | 3. Data | 4. Facts |
| ---------- | ----------------- | -------------------------- |
| `load inne`  | `load samochody`    | `load wypozyczenia`          |
| `load daty`  | `load uzytkownicy`  | `load zgloszenia wypozyczen` |
| `load czasy` | `load miejsca`      |                            |
|              | `load zloszenia`    |                            |

▒▒▒▒▒▒▒█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█  
▒▒▒▒▒▒▒█░▒▒▒▒▒▒▒▓▒▒▓▒▒▒▒▒▒▒░█  
▒▒▒▒▒▒▒█░▒▒▓▒▒▒▒▒▒▒▒▒▄▄▒▓▒▒░█░▄▄  
▒▒▄▀▀▄▄█░▒▒▒▒▒▒▓▒▒▒▒█░░▀▄▄▄▄▄▀░░█  
▒▒█░░░░█░▒▒▒▒▒▒▒▒▒▒▒█░░░░░░░░░░░█  
▒▒▒▀▀▄▄█░▒▒▒▒▓▒▒▒▓▒█░░░█▒░░░░█▒░░█  
▒▒▒▒▒▒▒█░▒▓▒▒▒▒▓▒▒▒█░░░░░░░▀░░░░░█  
▒▒▒▒▒▄▄█░▒▒▒▓▒▒▒▒▒▒▒█░░█▄▄█▄▄█░░█  
▒▒▒▒█░░░█▄▄▄▄▄▄▄▄▄▄█░█▄▄▄▄▄▄▄▄▄█  
▒▒▒▒█▄▄█░░█▄▄█░░░░░░█▄▄█░░█▄▄█  
  
