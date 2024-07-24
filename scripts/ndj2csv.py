import csv
import ndjson

with open('./train_1_1.jsonl', 'r') as f:
    data = ndjson.load(f)

with open('./users.csv', 'w', newline='') as f:
    # I'm assuming that each item has the same keys
    fields = data[0].keys()
    writer = csv.DictWriter(f, fieldnames=fields)
    writer.writeheader()
    for item in data:
        writer.writerow(item)
