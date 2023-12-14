import random
import names
from tools import random_date, create_license_plate_num
from datetime import datetime, timedelta

class Zgloszenia:
    def __init__(self, id_zgloszenia, car_list):
        self.id_zgloszenia = id_zgloszenia
        self.zglaszany_nr_rejestracyjny = ""
        self.nr_telefonu = ""
        self.godzina_wpisu = ""
        self.data_wpisu = ""
        self.id_pracownika = str(random.randint(0, 1000))
        self.imie = names.get_first_name()
        self.nazwisko = names.get_last_name()
        self.create_telephone_number()
        self.car_list = car_list
        self.create_entry_date_and_time()
        self.powod = str(random.randint(0, 27))
        self.potwierdzone = ""
        self.create_car()  # placeholder

    def create_telephone_number(self):
        for _ in range(9):
            self.nr_telefonu = self.nr_telefonu + str(random.randint(0, 9))

    def create_car(self):
        chance = random.randint(0, 100)
        if chance <= 80:
            car = random.choice(self.car_list)
            self.zglaszany_nr_rejestracyjny = car.nr_rejestracyjny
            self.potwierdzone = random.choice(['Y', 'N'])
        else:
            self.zglaszany_nr_rejestracyjny = create_license_plate_num()
            self.potwierdzone = "N"


    def create_entry_date_and_time(self):
        d1 = datetime.strptime('1/1/2019 1:30 PM', '%m/%d/%Y %I:%M %p')
        d2 = datetime.now()
        date_and_time = random_date(d1, d2)
        date = str(date_and_time)[0:10]
        timed = str(date_and_time)[11:]
        self.data_wpisu = date
        self.godzina_wpisu = timed

    def __str__(self):
        return str(self.id_pracownika) \
            + ";" + str(self.data_wpisu) \
            + ";" + str(self.godzina_wpisu) \
            + ";" + str(self.imie) \
            + ";" + str(self.nazwisko) \
            + ";" + str(self.nr_telefonu) \
            + ";" + str(self.id_zgloszenia) \
            + ";" + str(self.zglaszany_nr_rejestracyjny) \
            + ";" + str(self.powod) \
            + ";" + str(self.potwierdzone) + "\n"