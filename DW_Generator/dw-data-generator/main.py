from generator import Generator
from generate_csv.create_zgloszenia import generate_zgloszenia


def main():
    t1 = [1, 1, 2022]
    t2 = [1, 1, 2024]
    # liczba miejsc = 2*(n_rents)
    # liczba ocen = n_rents
    n_cars = 250
    n_users = 750
    n_rents = 15000
    n_reports = 1500

    generator = Generator(t1, t2, n_cars, n_users, n_rents, n_reports)

if __name__ == '__main__':
    main()
