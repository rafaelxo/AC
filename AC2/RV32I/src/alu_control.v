// alu_control.v - ALU Control (EX stage)
// Traduz ALUOp (vindo da Control Unit) + funct3 + funct7[5] na operacao
// real que a ALU deve executar.
//
// Codigos internos da ALU (alu_ctrl):
// 0000 ADD | 0001 SUB | 0010 SLL | 0011 SLT | 0100 SLTU
// 0101 XOR | 0110 SRL | 0111 SRA | 1000 OR  | 1001 AND

module alu_control (
    input  wire [1:0] alu_op,
    input  wire [2:0] funct3,
    input  wire       funct7_b5, // instr[30]
    output reg  [3:0] alu_ctrl
);

    always @(*) begin
        case (alu_op)
            2'b00: alu_ctrl = 4'b0000; // LW/SW/JALR/LUI -> sempre ADD

            2'b10: begin // R-type: usa funct3 + funct7[5]
                case (funct3)
                    3'b000: alu_ctrl = funct7_b5 ? 4'b0001 : 4'b0000; // SUB : ADD
                    3'b001: alu_ctrl = 4'b0010; // SLL
                    3'b010: alu_ctrl = 4'b0011; // SLT
                    3'b011: alu_ctrl = 4'b0100; // SLTU
                    3'b100: alu_ctrl = 4'b0101; // XOR
                    3'b101: alu_ctrl = funct7_b5 ? 4'b0111 : 4'b0110; // SRA : SRL
                    3'b110: alu_ctrl = 4'b1000; // OR
                    3'b111: alu_ctrl = 4'b1001; // AND
                    default: alu_ctrl = 4'b0000;
                endcase
            end

            2'b11: begin // I-type ALU: funct3 = 000 e sempre ADD (nao tem SUBI)
                case (funct3)
                    3'b000: alu_ctrl = 4'b0000; // ADDI
                    3'b001: alu_ctrl = 4'b0010; // SLLI
                    3'b010: alu_ctrl = 4'b0011; // SLTI
                    3'b011: alu_ctrl = 4'b0100; // SLTIU
                    3'b100: alu_ctrl = 4'b0101; // XORI
                    3'b101: alu_ctrl = funct7_b5 ? 4'b0111 : 4'b0110; // SRAI : SRLI
                    3'b110: alu_ctrl = 4'b1000; // ORI
                    3'b111: alu_ctrl = 4'b1001; // ANDI
                    default: alu_ctrl = 4'b0000;
                endcase
            end

            default: alu_ctrl = 4'b0000;
        endcase
    end

endmodule
