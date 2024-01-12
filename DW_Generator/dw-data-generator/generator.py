from tables.samochody import Samochod
from tables.uzytkownicy import Uzytkownik
from tables.wypozyczenia import Wypozyczenie
from tables.miejsca import Miejsce
from tables.oceny_przejazdu import Oceny_przejazdu
from generate_csv.create_zgloszenia import generate_zgloszenia
from generate_csv.create_zgloszenia import write_reports
import random
from tqdm import tqdm
import names
from tools import create_city


class Generator:
    def __init__(self, t1, t2, n_cars, n_users, n_rents, n_reports):
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
        self.t1_date = t1
        self.t2_date = t2
        self.generate_snapshot_1(n_cars, n_users, n_rents, n_reports)

        self.generate_snapshot_2(n_cars, n_users, n_rents, n_reports)

    def generate_rents(self, n, snapshot):
        for _ in tqdm(range(n)):

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
                                        miejsce_rozp.id_miejsca, miejsce_zak.id_miejsca, self.t1_date, self.t2_date, snapshot)
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
            for rent in tqdm(self.rental_list):
                opinion = Oceny_przejazdu(rent.id_wypozyczenia)
                self.opinion_list.append(opinion)
        else:
            podlista = self.rental_list[n:]
            for rent in tqdm(podlista):
                opinion = Oceny_przejazdu(rent.id_wypozyczenia)
                self.opinion_list.append(opinion)

    def generate_cars(self, n):
        for _ in tqdm(range(n)):
            car = Samochod(self.id_samochodu)
            self.id_samochodu += 1
            self.cars_list.append(car)

    def generate_users(self, n):
        for i in tqdm(range(n)):
            uzytkownik = Uzytkownik(self.id_uzytkownika)
            self.id_uzytkownika += 1
            self.users_list.append(uzytkownik)

    def generate_snapshot_1(self, n_cars, n_users, n_rents, n_reports):
        self.generate_cars(n_cars)
        print("Snap1 Cars generated!")
        self.generate_users(n_users)
        print("Snap1 Users generated!")
        self.generate_rents(n_rents, 1)
        print("Snap1 Rents generated!")
        self.generate_opinions(0)
        print("Snap1 Opinions generated!")
        self.report_list = generate_zgloszenia(n_reports, self.cars_list, self.rental_list)
        print("Snap1 Reports generated!")
        self.write_all('bulks')
        print("Snap1 Bulks written to files!")
        write_reports('zgloszenia1.csv', self.report_list)
        print("Snap1 Reports written to files!")

    def generate_snapshot_2(self, n_cars, n_users, n_rents, n_reports):
        self.generate_cars(n_cars)
        print("Snap2 Cars generated!")
        self.generate_users(n_users)
        print("Snap2 Users generated!")
        self.generate_rents(n_rents, 2)
        print("Snap2 Rents generated!")
        self.generate_opinions(n_rents)
        print("Snap2 Opinions generated!")
        new_reports = generate_zgloszenia(n_reports, self.cars_list, self.rental_list)
        print("Snap2 Reports generated!")
        self.report_list.extend(new_reports)
        self.write_all('bulks2')
        print("Snap2 Bulks written to files!")
        write_reports('zgloszenia2.csv', self.report_list)
        print("Snap2 Reports written to files!")


