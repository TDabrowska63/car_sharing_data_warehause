from random import randrange
from datetime import datetime, timedelta
import random
from geonamescache import GeonamesCache

def random_date(start, end):
    delta = end - start
    int_delta = (delta.days * 24 * 60 * 60) + delta.seconds
    random_second = randrange(int_delta)
    return start + timedelta(seconds=random_second)

def create_license_plate_num():
    nr_rejestracyjny = "G"
    option = random.choice(["2_digit_region", "3_digit_region"])
    if option == "2_digit_region":
        nr_rejestracyjny += random.choice('DAS')
    elif option == "3_digit_region":
        nr_rejestracyjny += random.choice(["SP", "BY", "CH", "CZ", "DA", "KA", "KS", "KW", "LE", "MB", "ND"])
    nr_rejestracyjny += " "
    for _ in range(5):
        nr_rejestracyjny += random.choice('ACEFGHJKLMNPRSTUWXYZ0123456789')
    return nr_rejestracyjny

def create_city():
    gc = GeonamesCache()
    cities = gc.get_cities()
    pomorskie_cities = []
    for city in cities.values():
        if city.get('countrycode') == 'PL' and city.get('admin1code') == '82':
            pomorskie_cities.append(city)
    if pomorskie_cities:
        city = random.choice(pomorskie_cities)
    else:
        city = random.choice(list(cities.values()))
    return city