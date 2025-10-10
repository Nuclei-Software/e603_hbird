
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

module NUCLEI_SPRAM_256X22_MW1 ( CLK, CEN, WEN, A, D, Q);

parameter DEPTH = 256;
parameter DW = 22;
parameter AW = 8;

input CLK;
input CEN;
input WEN;
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
                mem[A][i] <= D[i]; 
            end
        end
    end
end
endgenerate

endmodule
