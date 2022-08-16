import csv
import math


to_remove = []
with open("dataset.csv") as fp:
    reader = csv.reader(fp, delimiter=",", quotechar='"')
    # next(reader, None)  # skip the headers
    data_read = [row for row in reader]
    for i in range(len(data_read)):
        if (i ==0):
            continue
        new_line = data_read[i] 
        new_line[3] = "{:.1f}".format(int(new_line[3])/1000000)
        print(new_line[3])
        data_read[i] = new_line

    with open("newdataset.csv","w+") as newcsv:
        writer = csv.writer(newcsv, delimiter=",")
        writer.writerows(data_read)
