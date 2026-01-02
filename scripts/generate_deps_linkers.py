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

outfile = sys.argv[1]
region = sys.argv[2]
infiles = sys.argv[3:]
path = "build/" + region + "/"

if region not in valid_regions:
    print("Invalid data region")
    sys.exit(1)

def get_basename(path):
    idx = path.find(".ld")
    if idx == -1:
        print("Expected .ld input file")
        sys.exit(1)
    return path[0:idx]

rules = []

for infile in infiles:
    card = get_basename(infile)
    gbc_target = path + card + ".gbc"
    rules.append(("raw", path + card + "-01.raw"))

    with open(infile) as f:
        for line in f:
            line = line.strip()
            if len(line) == 0:
                continue
            if line[0] != "\"":
                continue
            rules.append((gbc_target, path + line[1:-1] + ".o"))

with open(outfile, "w") as f:
    for (target, dep) in rules:
        f.write(target)
        f.write(": ")
        f.write(dep)
        f.write("\n")
