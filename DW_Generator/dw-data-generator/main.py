from generator import Generator
from generate_csv.create_zgloszenia import generate_zgloszenia


def main():
    t1 = [1, 1, 2022]
    t2 = [1, 1, 2024]
    generator = Generator(7, 3, t1, t2)

if __name__ == '__main__':
    main()
