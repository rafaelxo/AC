// tb_top_processor.v - Testbench
// Carrega program.hex (via instr_mem), roda o processador por N ciclos
// e imprime/dumpa o conteudo dos registradores para validar a execucao.

`timescale 1ns / 1ps

module tb_top_processor;

    reg clk;
    reg rst;

    top_processor dut (
        .clk(clk),
        .rst(rst)
    );

    // Clock de 10ns de periodo (100MHz)
    always #5 clk = ~clk;

    integer i;

    initial begin
        clk = 0;
        rst = 1;

        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_top_processor);

        // 2 ciclos de reset
        @(posedge clk);
        @(posedge clk);
        rst = 0;

        // roda ciclos suficientes para executar todo o programa de teste
        // (51 instrucoes, sem desvios perdidos -> ~55 ciclos e suficiente,
        // mas damos margem ja que apos o HALT o processador fica em loop)
        repeat (80) @(posedge clk);

        $display("\n===================================================");
        $display(" RESULTADO FINAL DOS REGISTRADORES");
        $display("===================================================");
        for (i = 1; i < 32; i = i + 1) begin
            $display("x%0d \t= %0d \t(0x%08h)", i, dut.u_regfile.regs[i], dut.u_regfile.regs[i]);
        end

        $display("\n===================================================");
        $display(" VERIFICACAO DE MEMORIA DE DADOS");
        $display("===================================================");
        $display("mem[0] = %0d (0x%08h)  (esperado: 5, escrito por SW)",
                   dut.u_dmem.mem[0], dut.u_dmem.mem[0]);

        $display("\n===================================================");
        $display(" PC FINAL = 0x%08h (esperado: 0x000000C8 / 200, loop de HALT)", dut.pc_current);
        $display("===================================================");

        $finish;
    end

    // Monitor ciclo a ciclo (opcional, ajuda a debugar no waveform)
    initial begin
        $monitor("t=%0t | PC=0x%08h | instr=0x%08h | rd=%0d | wb_data=0x%08h | RegWrite=%b",
                  $time, dut.pc_current, dut.instr, dut.rd_addr, dut.write_back_data, dut.reg_write);
    end

endmodule
