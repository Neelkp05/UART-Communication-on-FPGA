module de2_top (
    input CLOCK_50,
    input [0:0] KEY,
    input UART_RXD,
    output [7:0] LCD_DATA,
    output LCD_RS,
    output LCD_EN,
    output LCD_RW,
    output LCD_ON
);
    wire reset = ~KEY[0];
    wire [7:0] rx_data;
    wire data_valid;

    assign LCD_ON = 1;

    uart_rx receiver (
        .clk(CLOCK_50),
        .reset(reset),
        .rx(UART_RXD),
        .data_out(rx_data),
        .data_valid(data_valid)
    );

    lcd_display lcd (
        .clk(CLOCK_50),
        .reset(reset),
        .data_in(rx_data),
        .data_valid(data_valid),
        .LCD_DATA(LCD_DATA),
        .LCD_RS(LCD_RS),
        .LCD_EN(LCD_EN),
        .LCD_RW(LCD_RW)
    );
endmodule
