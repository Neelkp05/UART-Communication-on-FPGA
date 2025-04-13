module uart_rx (
    input wire clk,           // 50MHz clock
    input wire reset,         // Reset (active high)
    input wire rx,            // UART RX input from ESP32
    output reg [7:0] data_out,// Received byte
    output reg data_valid     // Pulse when data is ready
);
    parameter CLOCK_FREQ = 50000000;
    parameter BAUD_RATE = 115200;
    parameter BAUD_TICK = CLOCK_FREQ / BAUD_RATE;  // ~434

    reg [15:0] baud_counter;
    reg [3:0] bit_counter;
    reg [9:0] shift_reg;
    reg receiving;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            baud_counter <= 0;
            bit_counter <= 0;
            shift_reg <= 0;
            receiving <= 0;
            data_out <= 0;
            data_valid <= 0;
        end else begin
            if (!receiving && !rx) begin
                receiving <= 1;
                baud_counter <= BAUD_TICK / 2;
                bit_counter <= 0;
            end else if (receiving) begin
                if (baud_counter == BAUD_TICK - 1) begin
                    baud_counter <= 0;
                    shift_reg <= {rx, shift_reg[9:1]};
                    bit_counter <= bit_counter + 1;
                    if (bit_counter == 9) begin
                        receiving <= 0;
                        if (shift_reg[9] == 1) begin
                            data_out <= shift_reg[8:1];
                            data_valid <= 1;
                        end
                    end
                end else begin
                    baud_counter <= baud_counter + 1;
                    data_valid <= 0;
                end
            end else data_valid <= 0;
        end
    end
endmodule
