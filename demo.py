#!/bin/python

import argparse
import collections
import csv
from datetime import datetime
from faker import Faker
import json
import os
import random
import time

class SdcDemoFactory(object):

    def __init__(self, use_case, run_type):

        self.use_case = use_case
        self.run_type = run_type
        self.runs = 1000 if run_type == 'data' else 1

        # Generate fake list of cashiers and grocery menu.
        fake = Faker()
        self.cashiers = [fake.name() for _ in range(5)]
        self.menu = {
            'lettuce': {'price': 1.5, 'sku': 'LET'},
            'grapefruit': {'price': 1, 'sku': 'GPF'},
            'tomato': {'price': 2, 'sku': 'TOM'},
            'rice': {'price': 1, 'sku': 'RIC'},
            'beans': {'price': 2, 'sku': 'BEN'},
            'milk': {'price': 3, 'sku': 'MLK'},
            'cheese': {'price': 2.5, 'sku': 'CHS'},
            'chicken': {'price': 3.5, 'sku': 'CHK'},
            'pork': {'price': 4, 'sku': 'PRK'},
            'avocado': {'price': 1, 'sku': 'AVC'},
            'turkey': {'price': 4, 'sku': 'TRK'}
        }

        # Determine record list.
        self.records = [self.dataFactory() for _ in range(self.runs)]

        # Look up which helper function to call, extract output.
        self.func_lookup = {'json': self.jsonFactory, 'csv': self.csvFactory}
        self.func_lookup[use_case]()


    def dataFactory(self):
        '''Generate the record as a list.'''

        output = []
        id_num = random.randint(1,9999999)
        time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        cashier = random.choice(self.cashiers)

        for _ in range(random.randint(1,15)):
            key = random.choice(list(self.menu.keys()))
            output.append({
                'transaction_id': id_num,
                'transaction_time': time,
                'item': key,
                'information': self.menu[key],
                'cashier': cashier
            })

        return output


    def jsonFactory(self):
        '''Generate json records.'''

        for count, record in enumerate(self.records):

            # Generate JSON.
            with open('./data/sdc/acme_legacycorp_output' + str(count) + '.txt', 'w') as f:
                json.dump(record, f)

            if count == 0 and self.run_type == 'preview':
                print(json.dumps(record, indent = 4))


    def csvFactory(self):

        with open('./data/sdc/acme_hardwork_output' + str(count) + '.csv', 'w') as f:
            wr = csv.writer(f, delimiter = ',')
            for record in self.records:
                wr.writerow(record)


if __name__ == '__main__':

    # Clean up old files.
    filelist = [f for f in os.listdir('./data/sdc')]
    for f in filelist:
        os.remove(os.path.join('./data/sdc', f))

    # Parse arguments.
    parser = argparse.ArgumentParser()
    parser.add_argument("--type", required=True, choices=['preview', 'data'])
    parser.add_argument("--usecase", required=True, choices=['json', 'csv'])
    args = parser.parse_args()

    # Run the demo!
    demo = SdcDemoFactory(use_case = args.usecase, run_type = args.type)
