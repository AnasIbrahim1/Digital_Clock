module clockDivider #(parameter n = 50000) (clk, rst, clk_out);
    input clk, rst;
    output reg clk_out;
    reg[31:0] cnt;
    always @(posedge clk) begin
        if (rst) begin
            cnt <= 0;
            clk_out <= 0;
        end
        else begin
            if (cnt == n - 1) begin
                cnt <= 0;
                clk_out <= ~clk_out;
             end
            else cnt <= cnt + 1;
        end
    end
endmodule

// period of FPGA clock == 1/(100,000,000) s = 10 ns
// period of this clock is 20 ns * n
// frequency of this clock is 1/20n * 10^9 Hz