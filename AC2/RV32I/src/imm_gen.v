// imm_gen.v - Imm-Gen, Unidade de Extensao de Imediatos (ID stage)
// Decodifica e gera o imediato sign-extended de 32 bits a partir
// do opcode da instrucao, cobrindo os formatos I, S, B, U e J.

module imm_gen (
    input  wire [31:0] instr,
    output reg  [31:0] imm_out
);

    wire [6:0] opcode = instr[6:0];

    localparam OP_RTYPE  = 7'b0110011;
    localparam OP_ITYPE  = 7'b0010011;
    localparam OP_LOAD   = 7'b0000011;
    localparam OP_STORE  = 7'b0100011;
    localparam OP_BRANCH = 7'b1100011;
    localparam OP_JAL    = 7'b1101111;
    localparam OP_JALR   = 7'b1100111;
    localparam OP_LUI    = 7'b0110111;

    always @(*) begin
        case (opcode)
            OP_ITYPE, OP_LOAD, OP_JALR: // I-type
                imm_out = {{20{instr[31]}}, instr[31:20]};

            OP_STORE: // S-type
                imm_out = {{20{instr[31]}}, instr[31:25], instr[11:7]};

            OP_BRANCH: // B-type
                imm_out = {{19{instr[31]}}, instr[31], instr[7],
                           instr[30:25], instr[11:8], 1'b0};

            OP_LUI: // U-type
                imm_out = {instr[31:12], 12'b0};

            OP_JAL: // J-type
                imm_out = {{11{instr[31]}}, instr[31], instr[19:12],
                           instr[20], instr[30:21], 1'b0};

            default:
                imm_out = 32'b0;
        endcase
    end

endmodule
