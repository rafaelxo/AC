// branch_comp.v - Comparador de Branch (EX stage)
// Avalia a condicao de desvio diretamente sobre rs1/rs2, independente
// da ALU, ja que cada B-type usa um tipo de comparacao diferente
// (igualdade, signed, unsigned).

module branch_comp (
    input  wire [31:0] rs1_data,
    input  wire [31:0] rs2_data,
    input  wire [2:0]  funct3,
    output reg          taken
);

    wire signed [31:0] a_signed = rs1_data;
    wire signed [31:0] b_signed = rs2_data;

    always @(*) begin
        case (funct3)
            3'b000: taken = (rs1_data == rs2_data);          // BEQ
            3'b001: taken = (rs1_data != rs2_data);          // BNE
            3'b100: taken = (a_signed < b_signed);           // BLT
            3'b101: taken = (a_signed >= b_signed);          // BGE
            3'b110: taken = (rs1_data < rs2_data);           // BLTU
            3'b111: taken = (rs1_data >= rs2_data);          // BGEU
            default: taken = 1'b0;
        endcase
    end

endmodule
