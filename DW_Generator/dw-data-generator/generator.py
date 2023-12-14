from tables.samochody import Samochod
from tables.uzytkownicy import Uzytkownik
from tables.wypozyczenia import Wypozyczenie
from tables.miejsca import Miejsce
from tables.oceny_przejazdu import Oceny_przejazdu
from generate_csv.create_zgloszenia import generate_zgloszenia
from generate_csv.create_zgloszenia import write_reports
import random
import names
from tools import create_city


class Generator:
    def __init__(self, n1, n2):
        self.id_miejsca = 1
        self.id_rent = 1
        self.id_samochodu = 1
        self.id_uzytkownika = 1
        self.users_list = []
        self.cars_list = []
        self.rental_list = []
        self.opinion_list = []
        self.places_list = []
        self.report_list = []
        self.generate_snapshot_1(n1)

        self.generate_snapshot_2(n2, n1)

    def generate_rents(self, n):
        for _ in range(n):

            miejsce_rozp = Miejsce(self.id_miejsca)
            self.id_miejsca += 1
            miejsce_zak = Miejsce(self.id_miejsca)
            self.id_miejsca += 1
            self.places_list.append(miejsce_rozp)
            self.places_list.append(miejsce_zak)

            samochod = random.choice(self.cars_list)
            podlista = [r for r in self.rental_list if r.id_samochodu == samochod.id_samochodu]
            przebieg = random.randint(0, 100)
            if len(podlista) != 0:
                max_przebieg = max(podlista, key=lambda x: x.przebieg, default=None)
                przebieg += max_przebieg.przebieg

                miejsce_zak_samochodu = self.places_list[max_przebieg.id_miejsca_zakonczenia - 1]
                miejsce_rozp.czy_miejsce_dedykowane = miejsce_zak_samochodu.czy_miejsce_dedykowane
                miejsce_rozp.miasto = miejsce_zak_samochodu.miasto
                miejsce_rozp.wspolrzedne = miejsce_zak_samochodu.wspolrzedne

            uzytkownik = random.choice(self.users_list)

            wypozyczenie = Wypozyczenie(self.id_rent, przebieg, samochod.id_samochodu, uzytkownik.id_uzytkownika,
                                        miejsce_rozp.id_miejsca, miejsce_zak.id_miejsca)
            self.id_rent += 1
            self.rental_list.append(wypozyczenie)

    def write_all(self, folder_name):
        with open('./'+ folder_name +'/opinions.bulk', 'w', encoding="utf-8") as file:
            for opinion in self.opinion_list:
                file.write(str(opinion))

        with open('./'+ folder_name +'/cars.bulk', 'w', encoding="utf-8") as file:
            for car in self.cars_list:
                file.write(str(car))

        with open('./'+ folder_name +'/users.bulk', 'w', encoding="utf-8") as file:
            for user in self.users_list:
                file.write(str(user))

        with open('./'+ folder_name +'/places.bulk', 'w', encoding="utf-8") as file:
            for place in self.places_list:
                file.write(str(place))

        with open('./'+ folder_name +'/rents.bulk', 'w', encoding="utf-8") as file:
            for rent in self.rental_list:
                file.write(str(rent))

    def generate_opinions(self, n):
        if n == 0:
            for rent in self.rental_list:
                opinion = Oceny_przejazdu(rent.id_wypozyczenia)
                self.opinion_list.append(opinion)
        else:
            podlista = self.rental_list[n:]
            for rent in podlista:
                opinion = Oceny_przejazdu(rent.id_wypozyczenia)
                self.opinion_list.append(opinion)

    def generate_cars(self, n):
        for _ in range(n):
            car = Samochod(self.id_samochodu)
            self.id_samochodu += 1
            self.cars_list.append(car)

    def generate_users(self, n):
        for i in range(n):
            uzytkownik = Uzytkownik(self.id_uzytkownika)
            self.id_uzytkownika += 1
            self.users_list.append(uzytkownik)

    def generate_snapshot_1(self, n):
        self.generate_cars(n)
        self.generate_users(n)
        self.generate_rents(2*n)
        self.generate_opinions(0)
        self.report_list = generate_zgloszenia(n, self.cars_list)
        self.write_all('bulks')
        write_reports('zgloszenia1.csv', self.report_list)

    def generate_snapshot_2(self, n2, n1):
        num_of_users = random.randint(2, n2)
        for _ in range(num_of_users):
            i = random.randint(0, n2-1)
            change = random.choice(['imie', 'nazwisko', 'adres'])
            if change == 'imie':
                self.users_list[i].imie = names.get_first_name()
            elif change == 'nazwisko':
                self.users_list[i].nazwisko = names.get_last_name()
            else:
                self.users_list[i].miasto_zamieszkania = create_city().get('name')

        self.generate_cars(n2)
        self.generate_users(n2)
        self.generate_rents(3*n2)
        self.generate_opinions(2*n1)
        num_of_changes = random.randint(3, len(self.report_list))
        for _ in range(num_of_changes):
            i = random.randint(0, n1 - 1)
            license_plate = self.report_list[i].zglaszany_nr_rejestracyjny
            if self.report_list[i].potwierdzone == 'N' and license_plate in [car.nr_rejestracyjny for car in self.cars_list]:
                self.report_list[i].potwierdzone = 'Y'

        new_reports = generate_zgloszenia(n2, self.cars_list)
        self.report_list.extend(new_reports)
        self.write_all('bulks2')
        write_reports('zgloszenia2.csv', self.report_list)


