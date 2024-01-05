import random
class Oceny_przejazdu:
    def __init__(self, id_wypozyczenia):
        self.id_wypozyczenia = id_wypozyczenia
        self.ocena_predkosci = self.generate_grade()
        self.ocena_techniki_jazdy = self.generate_grade()
        self.ocena_uzytkownika = self.generate_grade()
        if self.ocena_uzytkownika < 3:
            self.powod = random.randint(1, 27)
        else:
            self.powod = 0

    def generate_grade(self):
        choice = random.randint(0, 2)
        bottom = 0
        if choice != 0:
            bottom = 2.5
        return round(random.uniform(bottom, 5), 1)

    def __str__(self):
        return f"{str(self.id_wypozyczenia)}|" \
               f"{str(self.ocena_predkosci)}|" \
               f"{str(self.ocena_techniki_jazdy)}|" \
               f"{str(self.ocena_uzytkownika)}|" \
               f"{str(self.powod)}\n"