#!/usr/bin/env python3

import time
import random
import argparse
import colorama
import sys
import select
from colorama import Fore

parser = argparse.ArgumentParser(description="This script prints an image file to the console. The --image argument is mandatory.")
parser.add_argument("--image", required=True, help="image file to print")
parser.add_argument("--min", type=float, default=0.0005, help="minimum sleep interval")
parser.add_argument("--max", type=float, default=0.00015, help="maximum sleep interval")
args = parser.parse_args()

with open(args.image, 'r') as file:
    content = file.read()
    for character in content:
        time.sleep(random.uniform(args.min, args.max))
        print(character, end='', flush=True)

text = "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀Wake the fuck up, Samurai!⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
colors = [Fore.RED, Fore.GREEN]
current_color_index = 0
keystroke = 0

while keystroke == 0:
    color = colors[current_color_index]
    print(color + text, end="\r", flush=True)
    time.sleep(1)  # Wait for 1 second
    current_color_index = (current_color_index + 1) % len(colors)

    i, o, e = select.select( [sys.stdin], [], [], 0 )

    if (i):
        keystroke = 1
    else:
        keystroke = 0

   