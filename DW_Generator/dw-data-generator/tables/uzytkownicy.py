import names
import random
from geonamescache import GeonamesCache
from tools import create_city, random_date
from datetime import datetime, timedelta


class Uzytkownik:
    def __init__(self, id_uzytkownika):
        self.id_uzytkownika = id_uzytkownika
        self.nr_prawa_jazdy = ""
        self.imie = names.get_first_name()
        self.nazwisko = names.get_last_name()
        self.miasto_zamieszkania = create_city().get('name')
        self.data_uzyskania_prawa_jazdy = self.create_driving_licence_time()
        self.create_driving_license_num()

    def create_driving_license_num(self):
        for i in range(13):
            if i == 5 or i == 8:
                self.nr_prawa_jazdy += "/"
            else:
                self.nr_prawa_jazdy += str(random.randint(0,9))

    def create_driving_licence_time(self):
        choice = random.randint(0, 1)
        if choice == 0:
            d1 = datetime.strptime('1/1/2020 1:30 PM', '%m/%d/%Y %I:%M %p')
            d2 = datetime.now()
        else:
            d1 = datetime.strptime('1/1/2013 1:30 PM', '%m/%d/%Y %I:%M %p')
            d2 = datetime.strptime('1/1/2020 1:30 PM', '%m/%d/%Y %I:%M %p')

        licence_date = random_date(d1, d2)
        return licence_date.date()

    def __str__(self):
        return f"{str(self.id_uzytkownika)}|" \
               f"{str(self.nr_prawa_jazdy)}|" \
               f"{str(self.imie)}|" \
               f"{str(self.nazwisko)}|" \
               f"{str(self.miasto_zamieszkania)}|" \
               f"{str(self.data_uzyskania_prawa_jazdy)}\n"
