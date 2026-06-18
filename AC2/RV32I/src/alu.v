// alu.v - Unidade Logica e Aritmetica (EX stage)

module alu (
    input  wire [31:0] a,
    input  wire [31:0] b,
    input  wire [3:0]  alu_ctrl,
    output reg  [31:0] result,
    output wire         zero
);

    wire signed [31:0] a_signed = a;
    wire signed [31:0] b_signed = b;

    always @(*) begin
        case (alu_ctrl)
            4'b0000: result = a + b;                                   // ADD
            4'b0001: result = a - b;                                   // SUB
            4'b0010: result = a << b[4:0];                             // SLL
            4'b0011: result = (a_signed < b_signed) ? 32'b1 : 32'b0;   // SLT
            4'b0100: result = (a < b) ? 32'b1 : 32'b0;                  // SLTU
            4'b0101: result = a ^ b;                                   // XOR
            4'b0110: result = a >> b[4:0];                             // SRL
            4'b0111: result = a_signed >>> b[4:0];                     // SRA
            4'b1000: result = a | b;                                   // OR
            4'b1001: result = a & b;                                   // AND
            default: result = 32'b0;
        endcase
    end

    assign zero = (result == 32'b0);

endmodule
