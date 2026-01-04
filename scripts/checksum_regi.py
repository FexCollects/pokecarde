import struct
import sys
import itertools

def d_word(data, idx):
    return struct.unpack('<I', data[idx:idx+4])[0] 

def s_word(val):
    return struct.pack('<I', val) 


def pairwise(iterable):
    "s -> (s0, s1), (s1, s2), (s2, s3), ..."
    a, b = itertools.tee(iterable)
    next(b, None)
    return zip(a, b)

def read_binary_file():
    data = ""
    with open(sys.argv[1], 'rb') as f:
        data = f.read()
    return data

def find_all(a_str, sub):
    start = 0
    while True:
        start = a_str.find(sub, start)
        if start == -1: return
        yield start
        start += len(sub) # use start += 1 to find overlapping matches


chunk_lengths = [0,0,0,6,2,5,12,5,3,1,2,5,5,5,1,13,13,5]
chunk_names = [
    "UNKNOWN CHUNK 0x00",
    "UNKNOWN CHUNK 0x01",
    "END OF CHUNKS 0x02",
    "UNKNOWN CHUNK 0x03",
    "UNKNOWN CHUNK 0x04",
    "UNKNOWN CHUNK 0x05",
    "UNKNOWN CHUNK 0x06",
    "CUSTOM BERRY 0x07",
    "UNKNOWN CHUNK 0x08",
    "UNKNOWN CHUNK 0x09",
    "UNKNOWN CHUNK 0x0A",
    "UNKNOWN CHUNK 0x0B",
    "UNKNOWN CHUNK 0x0C",
    "BATTLE TRAINER 0x0D",
    "UNKNOWN CHUNK 0x0E",
    "CHECKSUM BYTES 0x0F",
    "CHECKSUM CRC 0x10",
    "DOME TRAINER 0x11",
]

bytewises = []
bytewise_results = []
wordwises = []
wordwise_results = []
crcs = []
crc_results = []
data = read_binary_file()

payloads=list(find_all(data,b'\x01\x00\x00\x00\x02\x02\x00\x02\x00\x00\x00\x04\x00\x80\x01\x00\x00'))
base_address = d_word(data, payloads[0] + 1)

def crc_one_payload(payload_start, payload_end):
    # move past the header to start of the chunks
    i = payload_start + 17

    while i < payload_end:
        chunk_type = data[i]
        # print("Processing chunk:", chunk_names[chunk_type])
        if chunk_type == 0x02: # END_OF_CHUNKS
            break
        elif chunk_type == 0x07: # CUSTOM_BERRY
            berry_address = d_word(data, i + 1)
            offset_size = berry_address - base_address
            data_idx = payload_start + offset_size
            bytewises.append([data_idx + 0x52C, data_idx, data_idx + 0x52C])
        elif chunk_type == 0x0D: # BATTLE_TRAINER
            trainer_address = d_word(data, i + 1)
            offset_size = trainer_address - base_address
            data_idx = payload_start + offset_size
            wordwises.append([data_idx + 0xB8, data_idx, data_idx + 0xB8])
        elif chunk_type == 0x0F: # CHECKSUM_BYTES
            raise NotImplementedError
            start_address = d_word(data, i + 5) - base_address
            end_address = d_word(data, i + 9) - base_address
            bytewise.append([i + 1, start_address, end_address])
        elif chunk_type == 0x10: # CHECKSUM_CRC
            start_offset = d_word(data, i + 5) - base_address
            end_offset = d_word(data, i + 9) - base_address
            crcs.append([i + 1, payload_start + start_offset, payload_start + end_offset])
        elif chunk_type == 0x11: # DOME_TRAINER
            raise NotImplementedError
            start_address = d_word(data, i + 1) - base_address
            wordwises.append([start_address + 0x13C, start_address, start_address + 0x13C])
        elif chunk_type < 0x02 or chunk_type > 0x11:
            print("Unknown chunk {0:X}".format(chunk_type))
            raise TypeError
        i += chunk_lengths[chunk_type]

# For each payload in payloads build a pair representing
# the starting index of the payload and the index one past
# the end of the payload. For the final payload the end of the
# stream is used instead.
for (start, end) in pairwise(payloads + [len(data)]):
    crc_one_payload(start, end)

# calculate and insert all wordwise checksums
for wordwise in wordwises:
    sum = 0
    for i in range(wordwise[1], wordwise[2], 4):
        sum = (sum + d_word(data, i)) & 0xFFFFFFFF
    wordwise_results.append(sum)
i = 0
for wordwise in wordwises:
    data = data[0:wordwise[0]] + s_word(wordwise_results[i]) + data[(wordwise[0] + 4):]
    i += 1


# calculate and insert all bytewise checksums
for bytewise in bytewises:
    sum = 0
    for i in range(bytewise[1], bytewise[2]):
        sum = (sum + data[i]) & 0xFFFFFFFF
    bytewise_results.append(sum)
i = 0
for bytewise in bytewises:
    data = data[0:bytewise[0]] + s_word(bytewise_results[i]) + data[(bytewise[0] + 4):]
    i += 1


# calculate and insert all CRC checksums
for crc in crcs:
    sum = 0x1121
    for i in range(crc[1], crc[2]):
        sum ^= data[i]
        for j in range(8):
            if(sum & 1):
                sum = (sum >> 1) ^ 0x8408
            else:
                sum >>= 1
    sum = ~sum & 0xFFFF
    crc_results.append(sum)

i = 0
for crc in crcs:
    data = data[0:crc[0]] + s_word(crc_results[i]) + data[(crc[0] + 4):]
    i += 1


# write the updated file
out = open(sys.argv[2], 'wb')
out.write(data)
