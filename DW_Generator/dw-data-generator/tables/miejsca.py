from geonamescache import GeonamesCache
import random
from tools import create_city


class Miejsce:
    def __init__(self, Id_miejsca):
        self.id_miejsca = Id_miejsca
        self.miasto = ""
        self.wspolrzedne = ""
        self.czy_miejsce_dedykowane = random.choice(["Y", "N"])
        self.get_city()

    def get_city(self):
        city = create_city()
        self.miasto = city.get('name')
        longi = city.get('longitude') + random.uniform(-0.05, 0.05)
        lati = city.get('latitude') + random.uniform(-0.05, 0.05)
        self.wspolrzedne = str(lati) + ", " + str(longi)

    def __str__(self):
        return f"{str(self.id_miejsca)}|" \
               f"{str(self.miasto)}|" \
               f"{str(self.wspolrzedne)}|" \
               f"{str(self.czy_miejsce_dedykowane)}\n"