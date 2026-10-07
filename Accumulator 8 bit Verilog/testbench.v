timescale 1ns/1ps

module accumulator_8bit_tb;

reg [7:0] A, B;
reg CLK, RESET;
wire [7:0] Q;

accumulator_8bit uut (
    .A(A),
    .B(B),
    .CLK(CLK),
    .RESET(RESET),
    .Q(Q)
);

always #5 CLK = ~CLK;

initial begin
    CLK = 0;
    RESET = 0;
    A = 0;
    B = 0;

    // Reset
    RESET = 1;
    #10;

    // 3 + 5 = 8
    RESET = 0;
    A = 8'b00000011;
    B = 8'b00000101;
    #10;

    // 2 + 1 = 3
    A = 8'b00000010;
    B = 8'b00000001;
    #10;

    // 255 + 1 = 0 (overflow)
    A = 8'b11111111;
    B = 8'b00000001;
    #10;

    // 170 + 5 = 175
    A = 8'b10101010;
    B = 8'b00000101;
    #10;

    $finish;
end

endmodule