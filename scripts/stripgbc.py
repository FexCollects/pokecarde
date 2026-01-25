import sys

with open(sys.argv[1], 'rb') as f:
    contents = f.read()

front_trim = 256

# The final byte contains "extra trim" that should also be deleted
# before that byte. Update the number to account for the ammount and move back one extra
# to account for the extra trim byte.
back_trim = contents[-1] + 1

with open(sys.argv[2], 'wb') as f:
    f.write(contents[front_trim:-back_trim])
