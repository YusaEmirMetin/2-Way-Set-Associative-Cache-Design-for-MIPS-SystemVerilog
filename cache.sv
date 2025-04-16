module cache (
    input logic [31:0] addr,
    input logic clk,
    input logic rst,
    output logic [31:0] out,
    output logic hit
);

    typedef struct {
        logic valid;
        logic [31:0] tag;
        logic [31:0] data;
        logic lru;
    } cache_line;

    cache_line cache_mem[2][4];

    logic [1:0] index;
    logic [31:0] tag;
    logic way_hit[2];

    initial begin
        for (int i = 0; i < 2; i++) begin
            for (int j = 0; j < 4; j++) begin
                cache_mem[i][j].valid = 1'b0;
                cache_mem[i][j].tag = 32'b0;
                cache_mem[i][j].data = 32'b0;
                cache_mem[i][j].lru = 1'b0;
            end
        end
    end

    always @(*) begin
        if (rst == 1'b0) begin
            for (int i = 0; i < 2; i++) begin
                for (int j = 0; j < 4; j++) begin
                    cache_mem[i][j].valid = 1'b0;
                    cache_mem[i][j].tag = 32'b0;
                    cache_mem[i][j].data = 32'b0;
                    cache_mem[i][j].lru = 1'b0;
                end
            end
        end
    end

    assign index = addr[3:2];
    assign tag = addr[31:4];

    always @(negedge clk) begin
        if (rst == 1'b1) begin
            way_hit[0] = (cache_mem[0][index].valid && cache_mem[0][index].tag == tag);
            way_hit[1] = (cache_mem[1][index].valid && cache_mem[1][index].tag == tag);

            if (way_hit[0]) begin
                hit = 1'b1;
                out = cache_mem[0][index].data;
                cache_mem[0][index].lru = 1'b0;
                cache_mem[1][index].lru = 1'b1;
            end else if (way_hit[1]) begin
                hit = 1'b1;
                out = cache_mem[1][index].data;
                cache_mem[1][index].lru = 1'b0;
                cache_mem[0][index].lru = 1'b1;
            end else begin
                hit = 1'b0;
                if (cache_mem[0][index].lru) begin
                    cache_mem[0][index].tag = tag;
                    cache_mem[0][index].data = addr / 4;
                    cache_mem[0][index].valid = 1'b1;
                    cache_mem[0][index].lru = 1'b0;
                    cache_mem[1][index].lru = 1'b1;
                    out = addr / 4;
                end else begin
                    cache_mem[1][index].tag = tag;
                    cache_mem[1][index].data = addr / 4;
                    cache_mem[1][index].valid = 1'b1;
                    cache_mem[1][index].lru = 1'b0;
                    cache_mem[0][index].lru = 1'b1;
                    out = addr / 4;
                end
            end
        end
    end

endmodule
