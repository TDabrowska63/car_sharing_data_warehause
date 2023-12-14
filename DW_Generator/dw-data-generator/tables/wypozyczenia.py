import random
from random import randrange
from datetime import datetime, timedelta
import tools

class Wypozyczenie:
    def __init__(self, id, przebieg, id_samochodu, id_uzytkownika, id_miejsca_rozpoczecia, id_miejsca_zakonczenia):
        self.id_wypozyczenia = id
        self.typ = random.choice(['calodobowy', 'nieograniczony'])
        self.czas_wypozyczenia, self.czas_zakonczenia = self.create_rental_time()
        self.przebieg = przebieg
        self.poziom_paliwa = str(random.randint(0, 100))
        self.przejechane_kilometry = str(random.randint(0, 100))
        self.id_samochodu = id_samochodu
        self.id_uzytkownika = id_uzytkownika
        self.id_miejsca_rozpoczecia = id_miejsca_rozpoczecia
        self.id_miejsca_zakonczenia = id_miejsca_zakonczenia

    def create_rental_time(self):
        d1 = datetime.strptime('1/1/2019 1:30 PM', '%m/%d/%Y %I:%M %p')
        d2 = datetime.now()
        start_time = tools.random_date(d1, d2)
        end_time = start_time + timedelta(hours=random.randint(1, 24)) + timedelta(minutes=random.randint(0, 59)) + timedelta(seconds=random.randint(0, 59))

        return start_time, end_time

    def __str__(self):
        return f"{str(self.id_wypozyczenia)}|" \
               f"{str(self.typ)}|" \
               f"{str(self.czas_wypozyczenia)}|" \
               f"{str(self.czas_zakonczenia)}|" \
               f"{str(self.przebieg)}|" \
               f"{str(self.poziom_paliwa)}|" \
               f"{str(self.przejechane_kilometry)}|" \
               f"{str(self.id_samochodu)}|" \
               f"{str(self.id_uzytkownika)}|" \
               f"{str(self.id_miejsca_rozpoczecia)}|" \
               f"{str(self.id_miejsca_zakonczenia)}\n"
