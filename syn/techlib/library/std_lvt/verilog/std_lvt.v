module LVT_NAND2_X1 (A, B, ZN);
    input A;
    input B;
    output ZN;

    not(ZN, w0);
    and(w0, A, B);

endmodule

module LVT_NOR2_X1 (A, B, ZN);
    input A;
    input B;
    output ZN;

    not(ZN, w0);
    or(w0, A, B);

endmodule

module LVT_XOR2_X1 (A, B, Z);
    input A;
    input B;
    input Z;

    xor(Z, A, B);

endmodule

module LVT_MUX2_X2 (A, B, S, Z);
    input A;
    input B;
    input S;
    output Z;

    mux (Z, A, B, S);

endmodule

module LVT_INV_X1 (A, ZN);
    input A;
    output ZN;

    not(ZN, A);

endmodule

module LVT_BUF_X4 (A, Z);
    input A;
    output Z;

    buf (Z, A);
endmodule

module LVT_CLKBUF_X1 (A, Z);
    input A;
    output Z;

    buf (Z, A);
endmodule


module LVT_CLKGATETST_X4 (CK, E, SE, GCK);
    input CK, E, SE;
    output GCK;

    reg NOTIFIER;
    supply1 wRN, wSN;

    buf      I0 (clk, CK);
    buf      I1 (wSE, SE);
    buf      I2 (wE, E);
    not      I3 (wclk, CK);
    or       I4 (w0, wE, wSE);
    latch    I5 (w1, w0, wclk, wRN, wSN, NOTIFIER);
    not      I6 (cond0, w1);
    or       I7 (GCK, cond0, clk);

endmodule

module LVT_CLKGATETSTP_X4 (CK, E, SE, GCK);
    input CK, E, SE;
    output GCK;

    reg NOTIFIER;
    supply1 wRN, wSN;

    buf      I0 (clk, CK);
    buf      I1 (wSE, SE);
    buf      I2 (wE, E);
    or       I3 (n0, wE, wSE);
    latch    I4 (w1, w0, clk, wRN, wSN, NOTIFIER);
    and      I5 (GCK, n1, clk);

endmodule

module LVT_DFFR_X1 (D, RN, CK, Q, QN);
    input D, RN, CK;
    output QN,Q;

    reg NOTIFIER;
    supply1 wSN;

    not   XX0 (wRN,RN);
    buf     IC (clk,CK);
    dff I0 (n0,D, clk, wRN, wSN, NOTIFIER);
    not     I2 (QN, n0);
    buf     I3 (Q, n0);


endmodule

module LVT_DFFS_X1 (D, SN, CK, Q, QN);
    input D, SN, CK;
    output QN, Q;

    reg NOTIFIER;
    supply1 wRN;

    buf   XX0 (wSN,SN);
    buf     IC (clk,CK);
    dff I0 (w0,D, clk, wRN, wSN, NOTIFIER);
    not     I2 (QN, w0);
    buf     I3 (Q, w0);

endmodule

module LVT_DFF_X1 (D, CK, Q, QN);
    input CK, D;
    output Q, QN;
    reg NOTIFIER;
    supply1 wSN,wRN;
    buf     IC (clk, CK);
    dff I0 (w0, D, clk, wRN, wSN, NOTIFIER);
    buf     I1 (Q, w0);
    not     I2 (QN, w0);
endmodule

module LVT_LOGIC0_X1 (Z);
    output Z;
    buf(Z, 0);
endmodule

module LVT_LOGIC1_X1 (Z);
    output Z;
    buf(Z, 1);
endmodule

primitive mux (out, in0, in1, sel);
   output out;
   input  in0, in1, sel;

   table
   1  ?   0  :  1 ;
   0  ?   0  :  0 ;                                                                                                                                                                                                                                           
   ?  1   1  :  1 ;
   ?  0   1  :  0 ;
   0  0   x  :  0 ;
   1  1   x  :  1 ;
   endtable

endprimitive 


primitive dff (out, in, clk, clear, set, NOTIFIER);
   output out;
   input  in, clk, clear, set, NOTIFIER;
   reg    out;

   table
   0  r   ?   1   ?   : ?  :  0  ; 
   1  r   1   ?   ?   : ?  :  1  ; 
   1  *   1   ?   ?   : 1  :  1  ; 
   0  *   ?   1   ?   : 0  :  0  ; 
   ?  f   ?   ?   ?   : ?  :  -  ; 
   *  b   ?   ?   ?   : ?  :  -  ; 
   ?  ?   ?   0   ?   : ?  :  1  ; 
   ?  b   1   *   ?   : 1  :  1  ; 
   1  x   1   *   ?   : 1  :  1  ; 
   ?  ?   0   1   ?   : ?  :  0  ; 
   ?  b   *   1   ?   : 0  :  0  ; 
   0  x   *   1   ?   : 0  :  0  ; 
   ?  ?   ?   ?   *   : ?  :  x  ; 
   endtable

endprimitive

primitive latch (out, in, hold, clear, set, NOTIFIER);
   output out;
   input  in, hold, clear, set, NOTIFIER;
   reg    out;

   table
   1  0   1   ?   ?   : ?  :  1  ; 
   0  0   ?   1   ?   : ?  :  0  ; 
   1  *   1   ?   ?   : 1  :  1  ; 
   0  *   ?   1   ?   : 0  :  0  ; 
   *  1   ?   ?   ?   : ?  :  -  ; 
   ?  ?   ?   0   ?   : ?  :  1  ; 
   ?  1   1   *   ?   : 1  :  1  ; 
   1  ?   1   *   ?   : 1  :  1  ; 
   ?  ?   0   1   ?   : ?  :  0  ; 
   ?  1   *   1   ?   : 0  :  0  ; 
   0  ?   *   1   ?   : 0  :  0  ; 
   ?  ?   ?   ?   *   : ?  :  x  ; 
   endtable

endprimitive

