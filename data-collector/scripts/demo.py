#!/bin/python

import argparse
import collections
from datetime import datetime
from faker import Faker
import os
import random
import time

class SdcDemoFactory(object):

    def __init__(self, use_case, run_type):

        self.use_case = use_case
        self.run_type = run_type
        self.runs = 1000 if run_type == 'data' else 1

        self.func_lookup = {
            'receipts': self.receipts()
        }

        output = self.func_lookup[use_case]

        if run_type == 'preview':
            print(output)

    def receipts(self):

        fake = Faker()
        cashiers = [fake.name() for _ in range(5)]
        menu = {
            "Apple": 1, "Avocado": 2.25, "Banana": 0.5, "Beef": 4, "Chicken": 3,
            "Chocolate chips": 2, "Cucumber": 1, "Lettuce": 1.5, "Pasta": 3,
            "Pistachios": 5, "Rice": 3, "Salmon": 7
        }

        for i in range(self.runs):
            items = collections.Counter(
                [random.choice(menu.keys()) for _ in range(random.randint(1,20))]
            )

            receipt = '\n'.join(['Thank you for shopping at','ACME GROCERY STORE !!!!!!\n',
                'Your receipt from your visit on', datetime.now().strftime('%B %d, %Y %H:%m:%S'),
                '\nYour cashier is: ', random.choice(cashiers), '\nItems Purchased:\n'])

            for item in items:
                receipt += ''.join(['{:2}'.format(str(items[item])), '   ', item,
                    '\t' * (2 - int(item == 'Chocolate chips')),
                    '{:6.2f}'.format(menu[item] * items[item]), '\n'])
            subtotal = sum(menu[item] * items[item] for item in items)
            tax = subtotal * 0.0625
            total = subtotal + tax
            receipt += '\n'.join(['-' * 31, 'Subtotal:\t\t${:6.2f}'.format(subtotal),
                'Tax:\t\t\t${:6.2f}'.format(tax), '-' * 31, 'TOTAL:\t\t\t${:6.2f}'.format(total)])

            with open(''.join(['/landing_zone/acme_receipts_', str(i), '.txt']), 'w') as f:
                f.write(receipt)
            time.sleep(0.25)

        return receipt

if __name__ == '__main__':

    # Clean up old files.
    filelist = [f for f in os.listdir('/landing_zone')]
    for f in filelist:
        os.remove(os.path.join('/landing_zone', f))

    # Parse arguments.
    parser = argparse.ArgumentParser()
    parser.add_argument("--type", required=True, choices=['preview', 'data'])
    parser.add_argument("--usecase", required=True, choices=['receipts'])
    args = parser.parse_args()

    # Run the demo!
    demo = SdcDemoFactory(use_case = args.usecase, run_type = args.type)
