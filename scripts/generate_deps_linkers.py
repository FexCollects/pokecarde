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

infile = sys.argv[1]
outfile = sys.argv[2]
region = sys.argv[3]
path = "build/" + region + "/"

if region not in valid_regions:
    print("Invalid data region")
    sys.exit(1)

def get_basename():
    idx = infile.find(".ld")
    if idx == -1:
        print("Expected .ld input file")
        sys.exit(1)
    return infile[0:idx]

card = get_basename()
gbc_target = path + card + ".gbc"
rules = []

with open(sys.argv[1]) as f:
    for line in f:
        line = line.strip()
        if len(line) == 0:
            continue
        if line.startswith("; rule"):
            parts = line.split(" ")
            rules.append((parts[2], parts[3]))
            continue
        if line[0] != "\"":
            continue
        rules.append((gbc_target, path + line[1:-1] + ".o"))

with open(sys.argv[2], "w") as f:
    rules.append(("raw", path + card + "-01.raw"))

    for (target, dep) in rules:
        f.write(target)
        f.write(": ")
        f.write(dep)
        f.write("\n")
