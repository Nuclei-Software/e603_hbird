    wire wen = ~we; //ACTIVE LOW
    wire cen = ~cs; //ACTIVE LOW

    if (DP == 128 && DW == 16 && MW == 16)
    begin: u_ram_128x16_mw16
    wire [15:0]    bwen = ~wem;

    NUCLEI_SPRAM_128X16_MW16    u_ram (
                 .A          (addr      ),
                 .D          (din       ),
                 .Q          (dout      ),
                 .CEN        (cen       ),//ACTIVE LOW
                 .WEN        (wen       ),//ACTIVE LOW
                 .BWEN       (bwen      ),//ACTIVE LOW
                 .CLK        (clk       ));

    end

    else if (DP == 32 && DW == 140 && MW == 140)
    begin: u_ram_32x140_mw140
    wire [139:0]    bwen = ~wem;

    NUCLEI_SPRAM_32X140_MW140    u_ram (
                 .A          (addr      ),
                 .D          (din       ),
                 .Q          (dout      ),
                 .CEN        (cen       ),//ACTIVE LOW
                 .WEN        (wen       ),//ACTIVE LOW
                 .BWEN       (bwen      ),//ACTIVE LOW
                 .CLK        (clk       ));

    end

    else if (DP == 256 && DW == 22 && MW == 1)
    begin: u_ram_256x22_mw1

    NUCLEI_SPRAM_256X22_MW1    u_ram (
                 .A          (addr      ),
                 .D          (din       ),
                 .Q          (dout      ),
                 .CEN        (cen       ),//ACTIVE LOW
                 .WEN        (wen       ),//ACTIVE LOW
                 .CLK        (clk       ));

    end

    else if (DP == 2048 && DW == 64 && MW == 1)
    begin: u_ram_2048x64_mw1

    NUCLEI_SPRAM_2048X64_MW1    u_ram (
                 .A          (addr      ),
                 .D          (din       ),
                 .Q          (dout      ),
                 .CEN        (cen       ),//ACTIVE LOW
                 .WEN        (wen       ),//ACTIVE LOW
                 .CLK        (clk       ));

    end

    else if (DP == 256 && DW == 21 && MW == 1)
    begin: u_ram_256x21_mw1

    NUCLEI_SPRAM_256X21_MW1    u_ram (
                 .A          (addr      ),
                 .D          (din       ),
                 .Q          (dout      ),
                 .CEN        (cen       ),//ACTIVE LOW
                 .WEN        (wen       ),//ACTIVE LOW
                 .CLK        (clk       ));

    end

    else if (DP == 1024 && DW == 32 && MW == 4)
    begin: u_ram_1024x32_mw4
    wire [31:0]    bwen_pre = ~{
                            {8{wem[3]}},
                            {8{wem[2]}},
                            {8{wem[1]}},
                            {8{wem[0]}}};
    wire [31:0]    bwen = bwen_pre[31:0];

    NUCLEI_SPRAM_1024X32_MW4    u_ram (
                 .A          (addr      ),
                 .D          (din       ),
                 .Q          (dout      ),
                 .CEN        (cen       ),//ACTIVE LOW
                 .WEN        (wen       ),//ACTIVE LOW
                 .BWEN       (bwen      ),//ACTIVE LOW
                 .CLK        (clk       ));

    end

    else if (DP == 128 && DW == 40 && MW == 1)
    begin: u_ram_128x40_mw1

    NUCLEI_SPRAM_128X40_MW1    u_ram (
                 .A          (addr      ),
                 .D          (din       ),
                 .Q          (dout      ),
                 .CEN        (cen       ),//ACTIVE LOW
                 .WEN        (wen       ),//ACTIVE LOW
                 .CLK        (clk       ));

    end

    else if (DP == 128 && DW == 27 && MW == 1)
    begin: u_ram_128x27_mw1

    NUCLEI_SPRAM_128X27_MW1    u_ram (
                 .A          (addr      ),
                 .D          (din       ),
                 .Q          (dout      ),
                 .CEN        (cen       ),//ACTIVE LOW
                 .WEN        (wen       ),//ACTIVE LOW
                 .CLK        (clk       ));

    end

