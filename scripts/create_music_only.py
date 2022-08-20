import csv
import math


to_remove = []
mean_followoers = 28.356


def create_music_only_dataset():
    with open("newdataset.csv") as fp:
        reader = csv.reader(fp, delimiter=",", quotechar='"')
        # next(reader, None)  # skip the headers
        data_read = [row for row in reader]
        new_data = []
        for i in range(len(data_read)):
            if i == 0:
                new_data.append(data_read[i])
                continue
            new_line = data_read[i]
            if new_line[1] == "Music":
                new_data.append(new_line)

        print(new_data)

        with open("music_pages_dataset.csv", "w+") as newcsv:
            writer = csv.writer(newcsv, delimiter=",")
            writer.writerows(new_data)


create_music_only_dataset()
