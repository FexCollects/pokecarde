import sys

with open(sys.argv[1], 'rb') as f:
    contents = f.read()

front_trim = 256
back_trim = contents.find(b'\xEE\x00\xFF\xEE\xEE\x00\xFF\x00\xEE\x00\xFF\xFF\xEE\x00\xFF\x99')

# The byte just before the EOF sequence contains "extra trim" that should also be deleted
# before that byte. Update the number to account for the ammount and move back one extra
# to account for the extra trim byte.
back_trim = back_trim - contents[back_trim - 1] - 1

with open(sys.argv[2], 'wb') as f:
    f.write(contents[front_trim:back_trim])
