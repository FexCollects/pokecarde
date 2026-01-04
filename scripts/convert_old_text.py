import sys

palettes = []

infile = sys.argv[1]
outfile = sys.argv[2]

content = []

def do_comment(line):
    return "\t; " + line.strip() + "\n"

def leading_digits(line):
    chars = []
    for c in line:
        if c.isdigit():
            chars.append(c)
        else:
            return "".join(chars)
    return "".join(chars)

def do_convert(line):
    # Text_EN "foobar"8 
    # Text_EN "foobar" 
    # Text_EN "foobar\v1"
    # Text_EN "foobar"8 ; commment
    # Text_EN "foobar" ; commment
    # Text_EN "foobar\v1" ; commment
    line = line.strip()
    parts = line.split('"')

    macro = parts[0].strip()
    text = parts[1].strip()
    pad = leading_digits(parts[2].strip())

    if macro != "Text_EN":
        raise ValueError

    pad_to = 0
    if len(pad) > 0:
        pad_to = int(pad)

    if pad_to != 0 and len(text) > pad_to:
        raise ValueError

    def fin(o):
        return '\tdb "' + o + '"\n'

    if len(text) == pad_to:
        return fin(text) 

    out = text + "@"
    while len(out) < pad_to:
        out = out + " "

    return fin(out)

with open(infile) as f:
    for line in f:
        if "Text_EN" in line:
            line = do_convert(line)
        if "Text_JP" in line:
            line = do_comment(line)
        content.append(line)

with open(outfile, "w") as f:
    header = False
    for line in content:
        leading_line = "INCLUDE" in line or "SECTION" in line
        if not header and not leading_line:
            f.write('INCLUDE "include/charmaps.asm"\n\nPUSHC gen3text\n') 
            header = True
        f.write(line)
    f.write("\nPOPC\n")
