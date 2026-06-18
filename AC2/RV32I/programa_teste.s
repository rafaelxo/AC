# programa_teste.s
# Programa de teste RV32I que exercita as 30 instrucoes obrigatorias.
# Convertido para program.hex pelo assembler.py.
#
# Convencao: enderecos em bytes, cada instrucao ocupa 4 bytes.

addi x1,  x0, 5          # addr0   x1 = 5
addi x2,  x0, 3          # addr4   x2 = 3
add  x3,  x1, x2         # addr8   x3 = 8
sub  x4,  x1, x2         # addr12  x4 = 2
and  x5,  x1, x2         # addr16  x5 = 1
or   x6,  x1, x2         # addr20  x6 = 7
xor  x7,  x1, x2         # addr24  x7 = 6
sll  x8,  x1, x2         # addr28  x8 = 40
srl  x9,  x1, x2         # addr32  x9 = 0
sra  x10, x1, x2         # addr36  x10 = 0
slt  x11, x2, x1         # addr40  x11 = 1
sltu x12, x2, x1         # addr44  x12 = 1
addi x13, x0, -1         # addr48  x13 = 0xFFFFFFFF
xori x14, x1, 3          # addr52  x14 = 6
ori  x15, x1, 3          # addr56  x15 = 7
andi x16, x1, 3          # addr60  x16 = 1
slti x17, x2, 5          # addr64  x17 = 1
sltiu x18, x2, 5         # addr68  x18 = 1
slli x19, x1, 2          # addr72  x19 = 20
srli x20, x13, 1         # addr76  x20 = 0x7FFFFFFF
srai x21, x13, 1         # addr80  x21 = 0xFFFFFFFF
sw   x1,  0(x0)          # addr84  mem[0] = 5
lw   x22, 0(x0)          # addr88  x22 = 5
beq  x1, x1, +8          # addr92  taken -> pula proxima
addi x23, x0, 999        # addr96  [SKIPPED]
addi x23, x0, 111        # addr100 x23 = 111
bne  x1, x2, +8          # addr104 taken -> pula proxima
addi x24, x0, 999        # addr108 [SKIPPED]
addi x24, x0, 222        # addr112 x24 = 222
blt  x2, x1, +8          # addr116 taken -> pula proxima
addi x25, x0, 999        # addr120 [SKIPPED]
addi x25, x0, 333        # addr124 x25 = 333
bge  x1, x2, +8          # addr128 taken -> pula proxima
addi x26, x0, 999        # addr132 [SKIPPED]
addi x26, x0, 444        # addr136 x26 = 444
bltu x2, x1, +8          # addr140 taken -> pula proxima
addi x27, x0, 999        # addr144 [SKIPPED]
addi x27, x0, 555        # addr148 x27 = 555
bgeu x1, x2, +8          # addr152 taken -> pula proxima
addi x28, x0, 999        # addr156 [SKIPPED]
addi x28, x0, 666        # addr160 x28 = 666
jal  x29, +8             # addr164 taken -> pula proxima, x29 = 168
addi x30, x0, 999        # addr168 [SKIPPED]
addi x30, x0, 777        # addr172 x30 = 777
lui  x31, 0x12345        # addr176 x31 = 0x12345000
jalr x5, 200(x0)         # addr180 salta para addr 200, x5 = 184
addi x0, x0, 0           # addr184 NOP (nao alcancado)
addi x0, x0, 0           # addr188 NOP
addi x0, x0, 0           # addr192 NOP
addi x0, x0, 0           # addr196 NOP
jal  x0, 0                # addr200 HALT: loop infinito sobre si mesmo
