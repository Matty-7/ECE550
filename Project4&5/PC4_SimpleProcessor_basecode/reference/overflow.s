# Overflow Testing Instructions

# Initialize values for overflow testing
addi $1, $0, 65535      # r1 = 65535 = 0x0000FFFF
sll $1, $1, 15          # r1 = r1 << 15 = 0x7FFF8000 = 2147450880(decimal)
addi $1, $1, 32767      # r1 = r2 + 32767 = 0x7FFFFFFF(hex) = 2147483647(decimal)
addi $2, $0, 1          # r2 = 1

# Overflow Addition
add $3, $1, $2          # r3 = r1 + r2 = 2147483648 (overflow addition), $rstatus = 1

# Overflow Subtraction
addi $2, $0, -1         # r2 = -1

# Additional Overflow Case
sub $3, $1, $2          # r3 = 2147483647 - (-1) = 2147483648 (overflow addi), $rstatus = 3