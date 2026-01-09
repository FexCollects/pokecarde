import struct
import sys

def d_word(data, idx):
    return struct.unpack('<I', data[idx:idx+4])[0]

def d_half(data, idx):
    return struct.unpack('<H', data[idx:idx+2])[0]

# Extract a single byte from a word by index counting right to left
# 0xDE AD BE EF
#    ^3 ^2 ^1 ^0
def mask(word, idx):
    return (word >> (8 * idx)) & 0xFF

def do_pkmn_crc(data, offset):
    def addr(idx):
        return offset + idx

    pv = d_word(data, addr(0))
    otid = d_word(data, addr(4))
    key1 = mask(pv ^ otid, 0)
    key2 = mask(pv ^ otid, 1)
    key3 = mask(pv ^ otid, 2)
    key4 = mask(pv ^ otid, 3)

    substructG = data[addr(32):addr(44)]
    substructA = data[addr(44):addr(56)]
    substructE = data[addr(56):addr(68)]
    substructM = data[addr(68):addr(80)]

    checksum = 0
    for i in range(addr(32), addr(80), 2):
        checksum = checksum + d_half(data, i)

    data[addr(28)] = mask(checksum, 0)
    data[addr(29)] = mask(checksum, 1)

    for i in range(0, 12, 4):
        substructG[i] ^= key1
        substructG[i+1] ^= key2
        substructG[i+2] ^= key3
        substructG[i+3] ^= key4

        substructA[i] ^= key1
        substructA[i+1] ^= key2
        substructA[i+2] ^= key3
        substructA[i+3] ^= key4

        substructE[i] ^= key1
        substructE[i+1] ^= key2
        substructE[i+2] ^= key3
        substructE[i+3] ^= key4

        substructM[i] ^= key1
        substructM[i+1] ^= key2
        substructM[i+2] ^= key3
        substructM[i+3] ^= key4


    orders = {
        0: (substructG, substructA, substructE, substructM),
        1: (substructG, substructA, substructM, substructE),
        2: (substructG, substructE, substructA, substructM),
        3: (substructG, substructE, substructM, substructA),
        4: (substructG, substructM, substructA, substructE),
        5: (substructG, substructM, substructE, substructA),
        6: (substructA, substructG, substructE, substructM),
        7: (substructA, substructG, substructM, substructE),
        8: (substructA, substructE, substructG, substructM),
        9: (substructA, substructE, substructM, substructG),
        10: (substructA, substructM, substructG, substructE),
        11: (substructA, substructM, substructE, substructG),
        12: (substructE, substructG, substructA, substructM),
        13: (substructE, substructG, substructM, substructA),
        14: (substructE, substructA, substructG, substructM),
        15: (substructE, substructA, substructM, substructG),
        16: (substructE, substructM, substructG, substructA),
        17: (substructE, substructM, substructA, substructG),
        18: (substructM, substructG, substructA, substructE),
        19: (substructM, substructG, substructE, substructA),
        20: (substructM, substructA, substructG, substructE),
        21: (substructM, substructA, substructE, substructG),
        22: (substructM, substructE, substructG, substructA),
        23: (substructM, substructE, substructA, substructG),
    }
    (substruct1, substruct2, substruct3, substruct4) = orders[pv % 24]

    return data[0:addr(32)] + substruct1 + substruct2 + substruct3 + substruct4 + data[addr(80):]

if __name__ == "__main__":
    infile = sys.argv[1]
    outfile = sys.argv[2]
    offset = 36

    with open(infile, 'rb') as f:
        data = bytearray(f.read())
    data = do_pkmn_crc(data, offset)

    out = open(outfile, 'wb')
    out.write(data)
