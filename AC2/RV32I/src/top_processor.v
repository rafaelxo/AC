// top_processor.v - Processador RV32I Monociclo
// Integra os 5 estagios (IF, ID, EX, MEM, WB) em um unico ciclo de clock.

module top_processor (
    input wire clk,
    input wire rst
);

    // ------------------------------------------------------------------
    // IF - Instruction Fetch
    // ------------------------------------------------------------------
    wire [31:0] pc_current;
    wire [31:0] pc_plus4;
    wire [31:0] pc_next;
    wire [31:0] instr;

    pc u_pc (
        .clk(clk),
        .rst(rst),
        .pc_next(pc_next),
        .pc_out(pc_current)
    );

    assign pc_plus4 = pc_current + 32'd4;

    instr_mem u_imem (
        .addr(pc_current),
        .instr(instr)
    );

    // Campos da instrucao
    wire [6:0] opcode  = instr[6:0];
    wire [4:0] rd_addr = instr[11:7];
    wire [2:0] funct3  = instr[14:12];
    wire [4:0] rs1_addr = instr[19:15];
    wire [4:0] rs2_addr = instr[24:20];
    wire       funct7_b5 = instr[30];

    // ------------------------------------------------------------------
    // ID - Instruction Decode
    // ------------------------------------------------------------------
    wire [31:0] reg_data1, reg_data2;
    wire [31:0] imm_ext;
    wire [31:0] write_back_data;

    reg_file u_regfile (
        .clk(clk),
        .rst(rst),
        .reg_write(reg_write),
        .rs1(rs1_addr),
        .rs2(rs2_addr),
        .rd(rd_addr),
        .write_data(write_back_data),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );

    imm_gen u_immgen (
        .instr(instr),
        .imm_out(imm_ext)
    );

    // Sinais de controle
    wire reg_write, alu_src_a, alu_src_b, mem_read, mem_write, branch, jump;
    wire [1:0] mem_to_reg, alu_op;

    control_unit u_control (
        .opcode(opcode),
        .reg_write(reg_write),
        .alu_src_a(alu_src_a),
        .alu_src_b(alu_src_b),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .jump(jump),
        .mem_to_reg(mem_to_reg),
        .alu_op(alu_op)
    );

    // ------------------------------------------------------------------
    // EX - Execute
    // ------------------------------------------------------------------
    wire [31:0] alu_operand_a;
    wire [31:0] alu_operand_b;
    wire [31:0] alu_result;
    wire        alu_zero;
    wire [3:0]  alu_ctrl_sig;
    wire        branch_taken;
    wire [31:0] branch_target;

    assign alu_operand_a = alu_src_a ? 32'b0      : reg_data1;
    assign alu_operand_b = alu_src_b ? imm_ext    : reg_data2;

    alu_control u_alu_ctrl (
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7_b5(funct7_b5),
        .alu_ctrl(alu_ctrl_sig)
    );

    alu u_alu (
        .a(alu_operand_a),
        .b(alu_operand_b),
        .alu_ctrl(alu_ctrl_sig),
        .result(alu_result),
        .zero(alu_zero)
    );

    branch_comp u_branch_comp (
        .rs1_data(reg_data1),
        .rs2_data(reg_data2),
        .funct3(funct3),
        .taken(branch_taken)
    );

    // alvo de branch/jal = PC + imediato
    assign branch_target = pc_current + imm_ext;

    // ------------------------------------------------------------------
    // MEM - Memory Access
    // ------------------------------------------------------------------
    wire [31:0] mem_read_data;

    data_mem u_dmem (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .addr(alu_result),
        .write_data(reg_data2),
        .read_data(mem_read_data)
    );

    // ------------------------------------------------------------------
    // WB - Write Back
    // ------------------------------------------------------------------
    assign write_back_data = (mem_to_reg == 2'b01) ? mem_read_data :
                              (mem_to_reg == 2'b10) ? pc_plus4      :
                                                       alu_result;

    // ------------------------------------------------------------------
    // Atualizacao do PC (proximo endereco)
    // ------------------------------------------------------------------
    wire is_jalr = jump && (opcode == 7'b1100111);

    assign pc_next = is_jalr               ? (alu_result & ~32'b1) :
                      jump                  ? branch_target         :
                      (branch && branch_taken) ? branch_target      :
                                                  pc_plus4;

endmodule
