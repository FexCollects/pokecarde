set -ex
 
# Cleanup test files
function cleanup {
     rm -f input.bin output.bin output.golden.bin
}
trap cleanup EXIT

# Convert the input hex into binary
xxd -r input.hex > input.bin

# Convert the expected output into binary
xxd -r output.gold.hex > output.golden.bin

# Run the script to create the output
python3 ../../../scripts/stripgbc.py input.bin output.bin

# Verify the output matches
diff output.bin output.golden.bin
