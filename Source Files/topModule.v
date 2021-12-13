module topModule(clk, rst, toDisplay, enable);
    input clk, rst;
    output[7:0] toDisplay;
    output[3:0] enable;
    reg[3:0] digits[3:0];
    wire clk_out;
    clockDivider #(50000000) (clk, rst, clk_out);
    integer i;
    always @(posedge clk_out, posedge rst) begin
        if (rst) for (i = 0; i < 4; i = i + 1) digits[i] <= 0;
        else begin
            if (digits[0] == 9) begin
                digits[0] <= 0;
                if (digits[1] == 5) begin
                    digits[1] <= 0;
                    if (digits[2] == 9) begin
                        digits[2] <= 0;
                        if (digits[3] == 5) digits[3] <= 0;
                        else digits[3] <= digits[3] + 1;
                    end
                    else digits[2] <= digits[2] + 1;
                end
                else digits[1] <= digits[1] + 1;
            end
            else digits[0] <= digits[0] + 1;
        end
    end
    wire[7:0] digitsDisplay[3:0];
    genvar j;
    generate for (j = 0; j < 4; j = j + 1) begin: block
        segDisplay digitsConverter(digits[j], 1, digitsDisplay[j]);
    end endgenerate
    digitSwitcher(clk, rst, digitsDisplay[0], digitsDisplay[1], digitsDisplay[2], digitsDisplay[3], toDisplay, enable);
endmodule
