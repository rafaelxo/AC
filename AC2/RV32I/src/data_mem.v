// data_mem.v - Memoria de Dados (MEM stage)
// Leitura combinacional (assincrona), escrita sincrona.
// Usada apenas pelas instrucoes LW e SW.

module data_mem (
    input  wire        clk,
    input  wire        mem_read,
    input  wire        mem_write,
    input  wire [31:0] addr,
    input  wire [31:0] write_data,
    output wire [31:0] read_data
);

    reg [31:0] mem [0:255]; // 256 words = 1KB de memoria de dados

    initial begin : init_mem
        integer i;
        for (i = 0; i < 256; i = i + 1)
            mem[i] = 32'b0;
    end

    assign read_data = mem[addr[31:2]];

    always @(posedge clk) begin
        if (mem_write)
            mem[addr[31:2]] <= write_data;
    end

endmodule
