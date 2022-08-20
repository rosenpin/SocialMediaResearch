import csv
import math


to_remove = []
mean_followoers = 28.356


def add_is_big_page():
    with open("206836009 – 318862398.csv") as fp:
        reader = csv.reader(fp, delimiter=",", quotechar='"')
        # next(reader, None)  # skip the headers
        data_read = [row for row in reader]
        for i in range(len(data_read)):
            if i == 0:
                continue
            new_line = data_read[i]
            big = "big" if (float(new_line[3]) > mean_followoers) else "small"
            new_line.append(big)
            data_read[i] = new_line

        print(data_read)
        with open("newdataset.csv", "w+") as newcsv:
            writer = csv.writer(newcsv, delimiter=",")
            writer.writerows(data_read)


def add_indian_or_not():
    with open("206836009 – 318862398.csv") as fp:
        reader = csv.reader(fp, delimiter=",", quotechar='"')
        # next(reader, None)  # skip the headers
        data_read = [row for row in reader]
        for i in range(len(data_read)):
            if i == 0:
                continue
            new_line = data_read[i]
            indian = "yes" if (new_line[4] == "India") else "no"
            new_line.append(indian)
            data_read[i] = new_line

        print(data_read)
        with open("newdataset.csv", "w+") as newcsv:
            writer = csv.writer(newcsv, delimiter=",")
            writer.writerows(data_read)


add_is_big_page()
