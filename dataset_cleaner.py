import csv
import math


def value_to_float(x):
    if type(x) == float or type(x) == int:
        return x
    if "K" in x:
        if len(x) > 1:
            return float(x.replace("K", "")) * 1000
        return 1000.0
    if "M" in x:
        if len(x) > 1:
            return float(x.replace("M", "")) * 1000000
        return 1000000.0
    if "B" in x:
        return float(x.replace("B", "")) * 1000000000
    return 0.0


to_remove = []
with open("dataset.csv") as fp:
    reader = csv.reader(fp, delimiter=",", quotechar='"')
    # next(reader, None)  # skip the headers
    data_read = [row for row in reader]
    for i in range(len(data_read)):
        new_line = data_read[i] 
        new_line[4] = math.ceil(value_to_float(new_line[4]))
        new_line[6] = math.ceil(value_to_float(new_line[6]))
        new_line[7] = math.ceil(value_to_float(new_line[7]))
        data_read[i] = new_line

    with open("newdataset.csv","w+") as newcsv:
        writer = csv.writer(newcsv, delimiter=",")
        writer.writerows(data_read)
