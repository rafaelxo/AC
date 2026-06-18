#!/usr/bin/env python3
# assembler.py - mini assembler RV32I para gerar program.hex
# Cobre as 30 instrucoes obrigatorias do trabalho.

def b(val, bits):
    return format(val & ((1 << bits) - 1), '0{}b'.format(bits))

REG = {f"x{i}": i for i in range(32)}

def rtype(funct7, rs2, rs1, funct3, rd, opcode):
    return int(b(funct7,7)+b(rs2,5)+b(rs1,5)+b(funct3,3)+b(rd,5)+b(opcode,7), 2)

def itype(imm, rs1, funct3, rd, opcode):
    return int(b(imm,12)+b(rs1,5)+b(funct3,3)+b(rd,5)+b(opcode,7), 2)

def stype(imm, rs2, rs1, funct3, opcode):
    imm_b = b(imm,12)
    return int(imm_b[0:7]+b(rs2,5)+b(rs1,5)+b(funct3,3)+imm_b[7:12]+b(opcode,7), 2)

def btype(imm, rs2, rs1, funct3, opcode):
    # imm e multiplo de 2, representa offset em bytes
    imm_b = b(imm, 13)  # imm[12:0], bit0 sempre 0
    bit12 = imm_b[0]
    bit11 = imm_b[1]
    bits10_5 = imm_b[2:8]
    bits4_1 = imm_b[8:12]
    return int(bit12+bits10_5+b(rs2,5)+b(rs1,5)+b(funct3,3)+bits4_1+bit11+b(opcode,7), 2)

def utype(imm20, rd, opcode):
    return int(b(imm20,20)+b(rd,5)+b(opcode,7), 2)

def jtype(imm, rd, opcode):
    imm_b = b(imm, 21)  # imm[20:0], bit0 sempre 0
    bit20 = imm_b[0]
    bits10_1 = imm_b[10:20]
    bit11 = imm_b[9]
    bits19_12 = imm_b[1:9]
    return int(bit20+bits10_1+bit11+bits19_12+b(rd,5)+b(opcode,7), 2)

OPC = {
    'R': 0b0110011, 'I': 0b0010011, 'LOAD': 0b0000011, 'STORE': 0b0100011,
    'BRANCH': 0b1100011, 'JAL': 0b1101111, 'JALR': 0b1100111, 'LUI': 0b0110111,
}

def R(name, rd, rs1, rs2, funct3, funct7):
    return ('R', name, rd, rs1, rs2, funct3, funct7)

program = []

def add(name, rd, rs1, rs2, funct3, funct7=0):
    program.append(('R', name, rd, rs1, rs2, funct3, funct7))
def addi(name, rd, rs1, imm, funct3):
    program.append(('I', name, rd, rs1, imm, funct3))
def load(name, rd, rs1, imm):
    program.append(('LOAD', name, rd, rs1, imm, 0b010))
def store(name, rs2, rs1, imm):
    program.append(('STORE', name, rs2, rs1, imm, 0b010))
def branch(name, rs1, rs2, imm, funct3):
    program.append(('BRANCH', name, rs1, rs2, imm, funct3))
def jal(name, rd, imm):
    program.append(('JAL', name, rd, imm))
def jalr(name, rd, rs1, imm):
    program.append(('JALR', name, rd, rs1, imm))
def lui(name, rd, imm20):
    program.append(('LUI', name, rd, imm20))

# ---------------- Programa de teste (cobre as 30 instrucoes) ----------------
addi('ADDI', 1, 0, 5, 0b000)              #0  addr0   x1=5
addi('ADDI', 2, 0, 3, 0b000)              #1  addr4   x2=3
add('ADD',   3, 1, 2, 0b000, 0b0000000)   #2  addr8   x3=8
add('SUB',   4, 1, 2, 0b000, 0b0100000)   #3  addr12  x4=2
add('AND',   5, 1, 2, 0b111, 0b0000000)   #4  addr16  x5=1
add('OR',    6, 1, 2, 0b110, 0b0000000)   #5  addr20  x6=7
add('XOR',   7, 1, 2, 0b100, 0b0000000)   #6  addr24  x7=6
add('SLL',   8, 1, 2, 0b001, 0b0000000)   #7  addr28  x8=40
add('SRL',   9, 1, 2, 0b101, 0b0000000)   #8  addr32  x9=0
add('SRA',  10, 1, 2, 0b101, 0b0100000)   #9  addr36  x10=0
add('SLT',  11, 2, 1, 0b010, 0b0000000)   #10 addr40  x11=1
add('SLTU', 12, 2, 1, 0b011, 0b0000000)   #11 addr44  x12=1
addi('ADDI', 13, 0, -1, 0b000)            #12 addr48  x13=0xFFFFFFFF
addi('XORI', 14, 1, 3, 0b100)             #13 addr52  x14=6
addi('ORI',  15, 1, 3, 0b110)             #14 addr56  x15=7
addi('ANDI', 16, 1, 3, 0b111)             #15 addr60  x16=1
addi('SLTI', 17, 2, 5, 0b010)             #16 addr64  x17=1
addi('SLTIU',18, 2, 5, 0b011)             #17 addr68  x18=1
addi('SLLI', 19, 1, 2, 0b001)             #18 addr72  x19=20
addi('SRLI', 20, 13, 1, 0b101)            #19 addr76  x20=0x7FFFFFFF
program.append(('I_SHIFT_ARITH', 'SRAI', 21, 13, 1, 0b101)) #20 addr80 x21=0xFFFFFFFF (tratado abaixo)
store('SW', 1, 0, 0)                      #21 addr84  mem[0]=5
load('LW', 22, 0, 0)                      #22 addr88  x22=5
branch('BEQ', 1, 1, 8, 0b000)             #23 addr92  taken -> +8
addi('ADDI', 23, 0, 999, 0b000)           #24 addr96  [SKIPPED]
addi('ADDI', 23, 0, 111, 0b000)           #25 addr100 x23=111
branch('BNE', 1, 2, 8, 0b001)             #26 addr104 taken -> +8
addi('ADDI', 24, 0, 999, 0b000)           #27 addr108 [SKIPPED]
addi('ADDI', 24, 0, 222, 0b000)           #28 addr112 x24=222
branch('BLT', 2, 1, 8, 0b100)             #29 addr116 taken -> +8
addi('ADDI', 25, 0, 999, 0b000)           #30 addr120 [SKIPPED]
addi('ADDI', 25, 0, 333, 0b000)           #31 addr124 x25=333
branch('BGE', 1, 2, 8, 0b101)             #32 addr128 taken -> +8
addi('ADDI', 26, 0, 999, 0b000)           #33 addr132 [SKIPPED]
addi('ADDI', 26, 0, 444, 0b000)           #34 addr136 x26=444
branch('BLTU', 2, 1, 8, 0b110)            #35 addr140 taken -> +8
addi('ADDI', 27, 0, 999, 0b000)           #36 addr144 [SKIPPED]
addi('ADDI', 27, 0, 555, 0b000)           #37 addr148 x27=555
branch('BGEU', 1, 2, 8, 0b111)            #38 addr152 taken -> +8
addi('ADDI', 28, 0, 999, 0b000)           #39 addr156 [SKIPPED]
addi('ADDI', 28, 0, 666, 0b000)           #40 addr160 x28=666
jal('JAL', 29, 8)                         #41 addr164 taken -> +8, x29=168
addi('ADDI', 30, 0, 999, 0b000)           #42 addr168 [SKIPPED]
addi('ADDI', 30, 0, 777, 0b000)           #43 addr172 x30=777
lui('LUI', 31, 0x12345)                   #44 addr176 x31=0x12345000
jalr('JALR', 5, 0, 200)                   #45 addr180 jump to addr 200, x5=184
addi('ADDI', 0, 0, 0, 0b000)              #46 addr184 NOP (nao alcancado)
addi('ADDI', 0, 0, 0, 0b000)              #47 addr188 NOP
addi('ADDI', 0, 0, 0, 0b000)              #48 addr192 NOP
addi('ADDI', 0, 0, 0, 0b000)              #49 addr196 NOP
jal('HALT', 0, 0)                         #50 addr200 loop infinito (halt)

# ---------------- Encoding ----------------
def encode(instr):
    kind = instr[0]
    if kind == 'R':
        _, name, rd, rs1, rs2, funct3, funct7 = instr
        return rtype(funct7, rs2, rs1, funct3, rd, OPC['R'])
    elif kind == 'I':
        _, name, rd, rs1, imm, funct3 = instr
        return itype(imm, rs1, funct3, rd, OPC['I'])
    elif kind == 'I_SHIFT_ARITH':
        _, name, rd, rs1, shamt, funct3 = instr
        imm = (0b0100000 << 5) | shamt  # SRAI: funct7=0100000 nos bits altos do imm
        return itype(imm, rs1, funct3, rd, OPC['I'])
    elif kind == 'LOAD':
        _, name, rd, rs1, imm, funct3 = instr
        return itype(imm, rs1, funct3, rd, OPC['LOAD'])
    elif kind == 'STORE':
        _, name, rs2, rs1, imm, funct3 = instr
        return stype(imm, rs2, rs1, funct3, OPC['STORE'])
    elif kind == 'BRANCH':
        _, name, rs1, rs2, imm, funct3 = instr
        return btype(imm, rs2, rs1, funct3, OPC['BRANCH'])
    elif kind == 'JAL':
        _, name, rd, imm = instr
        return jtype(imm, rd, OPC['JAL'])
    elif kind == 'JALR':
        _, name, rd, rs1, imm = instr
        return itype(imm, rs1, 0b000, rd, OPC['JALR'])
    elif kind == 'LUI':
        _, name, rd, imm20 = instr
        return utype(imm20, rd, OPC['LUI'])
    else:
        raise ValueError(f"unknown kind {kind}")

lines = []
for idx, instr in enumerate(program):
    code = encode(instr)
    name = instr[1]
    lines.append(f"{code:08x}")
    print(f"addr{idx*4:<4} idx{idx:<3} {name:<6} -> 0x{code:08x}")

with open('program.hex', 'w') as f:
    f.write('\n'.join(lines) + '\n')

print(f"\nTotal de instrucoes: {len(program)}")
print("program.hex gerado com sucesso.")
