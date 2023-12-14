from generate_csv.zgloszenia import Zgloszenia

def generate_zgloszenia(number_of_records, cars_list):
    report_list = []
    for i in range(number_of_records):
        report = Zgloszenia(i, cars_list)
        report_list.append(report)
    return report_list


def write_reports(filename, report_list):
    with open('./generate_csv/' + filename, 'w' , encoding="utf-8") as file:
        file.write("id_pracownika;data_wpisu;godzina_wpisu;imie;nazwisko;nr_telefonu;id_zgloszenia;zglaszany_numer_rejestracyjny;powod;potwierdzone\n")
        for report in report_list:
            file.write(str(report))