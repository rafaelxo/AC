// control_unit.v - Unidade de Controle Geral (combinacional)
// Gera os sinais de controle a partir do opcode da instrucao.
// Tabela-verdade documentada no relatorio tecnico.
//
// MemtoReg: 00 = resultado da ALU | 01 = dado da memoria | 10 = PC+4 (JAL/JALR)
// ALUSrcA : 0 = registrador rs1   | 1 = zero (usado por LUI)
// ALUSrcB : 0 = registrador rs2   | 1 = imediato
// ALUOp   : 00 = soma (LW/SW/JALR/LUI) | 10 = R-type (usa funct3/funct7)
//           11 = I-type ALU (usa funct3/funct7)

module control_unit (
    input  wire [6:0] opcode,
    output reg         reg_write,
    output reg         alu_src_a,
    output reg         alu_src_b,
    output reg         mem_read,
    output reg         mem_write,
    output reg         branch,
    output reg         jump,
    output reg  [1:0]  mem_to_reg,
    output reg  [1:0]  alu_op
);

    localparam OP_RTYPE  = 7'b0110011;
    localparam OP_ITYPE  = 7'b0010011;
    localparam OP_LOAD   = 7'b0000011;
    localparam OP_STORE  = 7'b0100011;
    localparam OP_BRANCH = 7'b1100011;
    localparam OP_JAL    = 7'b1101111;
    localparam OP_JALR   = 7'b1100111;
    localparam OP_LUI    = 7'b0110111;

    always @(*) begin
        // valores default (evita inferencia de latch)
        reg_write  = 1'b0;
        alu_src_a  = 1'b0;
        alu_src_b  = 1'b0;
        mem_read   = 1'b0;
        mem_write  = 1'b0;
        branch     = 1'b0;
        jump       = 1'b0;
        mem_to_reg = 2'b00;
        alu_op     = 2'b00;

        case (opcode)
            OP_RTYPE: begin
                reg_write = 1'b1;
                alu_src_b = 1'b0;
                alu_op    = 2'b10;
            end

            OP_ITYPE: begin
                reg_write = 1'b1;
                alu_src_b = 1'b1;
                alu_op    = 2'b11;
            end

            OP_LOAD: begin
                reg_write  = 1'b1;
                alu_src_b  = 1'b1;
                mem_read   = 1'b1;
                mem_to_reg = 2'b01;
                alu_op     = 2'b00;
            end

            OP_STORE: begin
                alu_src_b = 1'b1;
                mem_write = 1'b1;
                alu_op    = 2'b00;
            end

            OP_BRANCH: begin
                branch = 1'b1;
                // comparacao feita pelo modulo branch_comp, ALU nao e usada aqui
            end

            OP_JAL: begin
                reg_write  = 1'b1;
                jump       = 1'b1;
                mem_to_reg = 2'b10;
            end

            OP_JALR: begin
                reg_write  = 1'b1;
                alu_src_b  = 1'b1;
                jump       = 1'b1;
                mem_to_reg = 2'b10;
                alu_op     = 2'b00;
            end

            OP_LUI: begin
                reg_write  = 1'b1;
                alu_src_a  = 1'b1; // operando A = zero
                alu_src_b  = 1'b1; // operando B = imediato
                mem_to_reg = 2'b00;
                alu_op     = 2'b00; // ALU faz 0 + imm
            end

            default: begin
                // instrucao nao reconhecida: nenhum sinal ativo
            end
        endcase
    end

endmodule
