module clk_div
    (
     input mclk,
	  input rst,
	  output clk
	 );
	 
   reg clk;
   
	always@(posedge mclk or posedge rst)
	  if (rst)
	      clk <= 0;
	  else
	      clk <= ~clk;

endmodule

