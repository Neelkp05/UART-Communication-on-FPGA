module de2 (
    input CLOCK_50,
    input [3:0] KEY,
    input [3:0] SW,
    output [0:0] LEDR,
    output UART_TXD
);
    wire reset = ~KEY[0];
    wire [7:0] data = {4'b0, SW};

    uart_tx transmitter (
        .clk(CLOCK_50),
        .reset(reset),
        .start(~KEY[1]),
        .data_in(data),
        .tx(UART_TXD),
        .busy(LEDR[0])
    );
endmodule
