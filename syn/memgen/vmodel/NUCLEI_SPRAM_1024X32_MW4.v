
//=====================================================================
//
//--  #     # #     #  #####  #       #######   ###
//--  ##    # #     # #     # #       #          #
//--  # #   # #     # #       #       #          #
//--  #  #  # #     # #       #       #####      #
//--  #   # # #     # #       #       #          #
//--  #    ## #     # #     # #       #          #
//--  #     #  #####   #####  ####### #######   ###
//
//=====================================================================
//
// Designer: Memgen
//
// Description:
//  The top level dummy RAM module
//
//====================================================================

module NUCLEI_SPRAM_1024X32_MW4 ( CLK, CEN, WEN, BWEN, A, D, Q);

parameter DEPTH = 1024;
parameter DW = 32;
parameter AW = 10;

input CLK;
input CEN;
input WEN;
input [DW-1:0] BWEN;
input [AW-1:0] A;
input [DW-1:0] D;
output [DW-1:0] Q;

reg [DW-1:0] mem[DEPTH-1:0];
reg [DW-1:0] dout;

assign Q = dout;

always @(posedge CLK) begin
    if (CEN == 1'b0) begin
        if (WEN == 1'b1) begin
            dout <= mem[A];
        end
    end
end

genvar i;
 
generate
for (i=0; i<DW; i=i+1) begin
    always @(posedge CLK) begin
        if (CEN == 1'b0) begin
            if (WEN == 1'b0) begin
                if (~BWEN[i]) begin
                    mem[A][i] <= D[i]; 
                end
            end
        end
    end
end
endgenerate

endmodule
