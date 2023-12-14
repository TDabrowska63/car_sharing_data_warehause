import random
class Oceny_przejazdu:
    def __init__(self, id_wypozyczenia):
        self.id_wypozyczenia = id_wypozyczenia
        self.ocena_predkosci = random.uniform(0, 5)
        self.ocena_techniki_jazdy = random.uniform(0, 5)
        self.ocena_uzytkownika = random.uniform(0, 5)
        if self.ocena_uzytkownika < 3:
            self.powod = random.randint(1, 27)
        else:
            self.powod = 0

    def __str__(self):
        return f"{str(self.id_wypozyczenia)}|" \
               f"{str(self.ocena_predkosci)}|" \
               f"{str(self.ocena_techniki_jazdy)}|" \
               f"{str(self.ocena_uzytkownika)}|" \
               f"{str(self.powod)}\n"