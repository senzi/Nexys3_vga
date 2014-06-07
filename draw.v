`timescale 1 ns / 1 ns


module draw(clk_25, v_count, h_count, rgb);
   input           clk_25;
   input [9:0]     v_count;
   input [9:0]     h_count;
   output [7:0]    rgb;
   reg [7:0]       rgb;
   
   reg [9:0]       box_x;
   reg [9:0]       box_y;
   parameter [6:0] box_height = 7'b0100100;
   parameter [6:0] box_width = 7'b0100100;
   
   parameter [9:0] porchleft = 10'b0010010000;
   parameter [9:0] porchtop = 10'b0000100100;
   parameter [9:0] porchbottom = 10'b0111110100;
   parameter [9:0] porchright = 10'b1100010000;
   
   reg             flag_up;
   reg             flag_left;
   
   
   always @(posedge clk_25)
      
      begin
         if ((h_count >= box_x) & (h_count < box_x + box_width) & (v_count >= box_y) & (v_count < box_y + box_height))
            rgb <= 8'hA5;
         else if ((h_count >= porchleft) & (h_count < porchright) & (v_count >= porchtop) & (v_count < porchbottom))
            rgb <= 8'hce;
         else
            rgb <= 8'b00000000;
         
         if (h_count == 10'b0000000001 & v_count == 10'b0000000001)
         begin
            if (flag_left == 1'b0)
            begin
               box_x <= box_x + 1;
               if (box_x + box_width == porchright - 1)
                  flag_left <= 1'b1;
            end
            else
            begin
               box_x <= box_x - 1;
               if (box_x == porchleft)
                  flag_left <= 1'b0;
            end
            if (flag_up == 1'b0)
            begin
               box_y <= box_y + 1;
               if (box_y + box_height == porchbottom - 1)
                  flag_up <= 1'b1;
            end
            else
            begin
               box_y <= box_y - 1;
               if (box_y == porchtop)
                  flag_up <= 1'b0;
            end
         end
      end
   
endmodule
