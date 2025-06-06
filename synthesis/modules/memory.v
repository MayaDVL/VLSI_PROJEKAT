module memory #(
    parameter ADDR_WIDTH = 16,
    parameter DATA_WIDTH = 16
)(
    input clk,
    input rst_n;
    input we,
    input [ADDR_WIDTH-1:0] addr,
    input [DATA_WIDTH-1:0] data,
    output [DATA_WIDTH-1:0] out
);

    reg [ADDR_WIDTH-1:0] addr_next, addr_reg;
    reg [DATA_WIDTH-1:0] mem_next [63:0], mem_reg [63:0];

    assign out = mem_reg[addr_reg];

    integer i;

    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            addr_reg <= 4'h0;
            for (i = 0; i < 16; i = i + 1)
                mem_reg[i] <= {DATA_WIDTH{1'b0}};
    end else begin
        addr_reg <= addr_next;
        for (i = 0; i < 64; i = i + 1)
            mem_reg[i] <= mem_next[i];
        end
    end

    always @(*) begin

        for (i = 0; i < 64; i = i + 1)
            mem_next[i] = mem_reg[i];

        if (we) // upis
            mem_next[addr] = data;

        addr_next = addr;
    end
endmodule