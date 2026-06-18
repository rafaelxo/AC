// reg_file.v - Banco de Registradores (ID stage / WB stage)
// 32 registradores de 32 bits. x0 e rigidamente aterrado em zero.
// Leitura combinacional (assincrona), escrita sincrona (borda de subida).

module reg_file (
    input  wire        clk,
    input  wire        rst,
    input  wire        reg_write,
    input  wire [4:0]  rs1,
    input  wire [4:0]  rs2,
    input  wire [4:0]  rd,
    input  wire [31:0] write_data,
    output wire [31:0] read_data1,
    output wire [31:0] read_data2
);

    reg [31:0] regs [0:31];
    integer i;

    // Leitura assincrona, x0 sempre retorna zero
    assign read_data1 = (rs1 == 5'b0) ? 32'b0 : regs[rs1];
    assign read_data2 = (rs2 == 5'b0) ? 32'b0 : regs[rs2];

    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1)
                regs[i] <= 32'b0;
        end else if (reg_write && rd != 5'b0) begin
            regs[rd] <= write_data;
        end
    end

endmodule
