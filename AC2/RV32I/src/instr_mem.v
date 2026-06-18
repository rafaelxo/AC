// instr_mem.v - Memoria de Instrucoes (IF stage)
// Leitura combinacional (assincrona), endereco em bytes, instrucoes word-aligned.
// O conteudo e carregado de "program.hex" via $readmemh.

module instr_mem (
    input  wire [31:0] addr,
    output wire [31:0] instr
);

    reg [31:0] mem [0:255]; // 256 words = 1KB de memoria de instrucoes

    initial begin
        $readmemh("program.hex", mem);
    end

    // addr[31:2] descarta os 2 bits menos significativos (alinhamento de word)
    assign instr = mem[addr[31:2]];

endmodule
