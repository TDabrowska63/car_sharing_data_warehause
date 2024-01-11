from generator import Generator
from generate_csv.create_zgloszenia import generate_zgloszenia


def main():
    t1 = [1, 1, 2022]
    t2 = [1, 1, 2024]
    # liczba wypozyczen = 3*n1 + 3*n2
    # liczba samochodow = n1/4 + n2/4
    # liczba uzytkownikow = n1 + n2
    # liczba zgloszen = n1 + n2
    # liczba miejsc = 2*(liczba wypozyczen)
    # liczba ocen = liczba wypozyczen
    n1 = 1000
    n2 = 1000

    generator = Generator(n1, n2, t1, t2)

if __name__ == '__main__':
    main()
