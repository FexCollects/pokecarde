import sys

valid_regions = [
  'JP',
  'EN',
  'FR',
  'IT',
  'DE',
  'ES',
]

if len(sys.argv) < 4:
    print("Expected 4 parameters")
    sys.exit(1)

def get_basename(path):
    idx = infile.find(".asm")
    if idx == -1:
        print("Expected .asm input file")
        sys.exit(1)
    return path[0:idx]

outfile = sys.argv[1]
region = sys.argv[2]
infiles = sys.argv[3:]
path = "build/" + region + "/"

def extract_path(line):
    start = line.find("\"") + 1
    if start == -1:
        print("Expected quoted string")
        sys.exit(1)
    end = line.find("\"", start)
    if end == -1:
        print("Expected quoted string")
        sys.exit(1)
    return line[start:end] 

deps = []

for infile in infiles:
    card = get_basename(infile)
    target = path + card + ".o"

    with open(infile) as f:
        for line in f:
            line = line.strip()
            if len(line) == 0:
                continue

            uline = line.upper()
            is_dep = uline.startswith("INCBIN") or uline.startswith("INCLUDE") or uline.startswith("READFILE")
            if not is_dep:
                continue

            deps.append((target, extract_path(line)))

with open(outfile, "w") as f:
    for (target, dep) in deps:
        f.write(target)
        f.write(": ")
        f.write(dep)
        f.write("\n")
