`timescale 1 ns / 1 ns


module top(i_clk, rgb, vs, hs);
   input        i_clk;
   output [7:0] rgb;
   output       vs;
   output       hs;
   
   
   wire         clk25;
   wire [9:0]   vcount;
   wire [9:0]   hcount;
   wire [3:0]   keynum;
   
   
   clk_div u1(.clk_in(i_clk), .clk_25(clk25));
   
   vga u2(.clk_25(clk25), .vs(vs), .hs(hs), .vpixel(vcount), .hpixel(hcount));
   
   draw u3(.clk_25(clk25), .v_count(vcount), .h_count(hcount), .rgb(rgb));
   
endmodule
