// Traffic Light Controller Module
module traffic_light_controller (
    input clk,       // Clock input
    input rst_n,     // Reset input (active low)
    output reg red,  // Red light output
    output reg yellow,// Yellow light output
    output reg green // Green light output
    );

    // State enum definition
    typedef enum logic [1:0] {
        RED,
        YELLOW,
        GREEN
    } state_t;

    // State register
    reg [1:0] state;

    // State machine
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            state <= RED; // Initialize state to RED on reset
        end else begin
            case (state)
                RED: begin
                    red <= 1;
                    yellow <= 0;
                    green <= 0;
                    state <= YELLOW;
                end
                YELLOW: begin
                    red <= 0;
                    yellow <= 1;
                    green <= 0;
                    state <= GREEN;
                end
                GREEN: begin
                    red <= 0;
                    yellow <= 0;
                    green <= 1;
                    state <= RED;
                end
                default: state <= RED;
            endcase
        end
    end

endmodule
