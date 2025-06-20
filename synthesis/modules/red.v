module red( // rising edge detector
    input clk,
    input rst_n;
    input in,
    output out
);
    reg ff1_next, ff1_reg;
    reg ff2_next, ff2_reg;

    assign out = ff1_reg & ~ff2_reg; // 0->1 --> out s= 1

    always @(posedge clk, negedge rest_n) begin
        if (!rst_n) begin
            ff1_reg <= 1'b0;
            ff2_reg <= 1'b0;
        end else begin
            ff1_reg <= ff1_next;
            ff2_reg <= ff2_next;
        end
    end

    always @(*) begin
        ff1_next = in;
        ff2_next = ff1_reg;
    end
    
endmodule