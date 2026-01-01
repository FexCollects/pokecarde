import sys

cards = []

with open(sys.argv[1]) as f:
    for line in f:
        line = line.strip()
        if len(line) == 0:
            continue
        if line[0] == "#":
            continue
        idx = line.find("build/")
        if idx == -1:
            print("Unexpected dep line:", line)
            sys.exit(1)
        cards.append(line[idx:])


with open(sys.argv[2], "w") as f:
    for card in cards:
        f.write("verify: ")
        f.write(card)
        f.write("\n")
