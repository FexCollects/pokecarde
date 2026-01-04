import sys

palettes = []

infile = sys.argv[1]
outfile = sys.argv[2]

with open(infile) as f:
    for line in f:
        line = line.strip()
        if len(line) == 0:
            continue
        if line[0] == "#":
            continue
        idx = line.find("RGB ")
        if idx == -1:
            print("Unexpected palette line:", line)
            sys.exit(1)
        color555 = [int(x.strip()) for x in line[idx+3:].split(",")]
        color888 = [str(int(x/31 * 255)) for x in color555]
        palettes.append(" ".join(color888))

with open(outfile, "w") as f:
    f.write("JASC-PAL\r\n")
    f.write("0100\r\n")
    f.write(str(len(palettes)))
    f.write("\r\n")
    for palette in palettes:
        f.write(palette)
        f.write("\r\n")
