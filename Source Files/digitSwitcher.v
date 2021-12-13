module digitSwitcher(clk, rst, digit0, digit1, digit2, digit3, out, enable);
    input clk, rst;
    input[7:0] digit0, digit1, digit2, digit3;
    // n by m array wire[m - 1:0] digit[n - 1:0]
    wire[7:0] digit[3:0]; 
    assign digit[0] = digit0; assign digit[1] = digit1; assign digit[2] = digit2; assign digit[3] = digit3;
    output reg[7:0] out;
    output reg[3:0] enable;
    reg[1:0] cnt;
    wire clk_out;
    clockDivider divide(clk, rst, clk_out);
    always @(posedge clk_out, posedge rst) begin
        if (rst) cnt <= 0;
        else cnt <= cnt + 1;
        out <= digit[cnt];
        enable = 4'b1111 - (1 << cnt);
    end
endmodule