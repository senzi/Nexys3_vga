module vga_display
     (
      input  [10:0]count_h,
		input  [ 9:0]count_v,
		input  [ 7:0]rom_dout,
		input  [14:0]addr,
		output [ 7:0]rgb_8bits,
		output hsync,
		output vsync
     );
	
wire [7:0]  rom_dout; 
wire [14:0] addr;

wire [7:0]rgb_8bits;
wire hsync;
wire vsync;

wire [10:0] count_h;
wire [ 9:0] count_v;


parameter pixel_h = 11'd600;   //800*600*72 HZ ��͵���������ʼ�㣺215����಻����1015.
parameter pixel_v = 10'd250;   //800*600*72 HZ ��͵���������ʼ�㣺26�� ��಻����626.

parameter img_h = 11'd100; 
parameter img_v = 10'd150;


assign hsync = (count_h<=11'd127)? 1'b0 : 1'b1;    //��ͬ���ε�׼��ʱ��
assign vsync = (count_v<=10'd3)?   1'b0 : 1'b1;    //��ͬ���ε�׼��ʱ��

assign rgb_8bits = (( count_h > pixel_h ) && ( count_h < ( pixel_h + img_h + 11'd1 )) 
                 && ( count_v > pixel_v ) && ( count_v < ( pixel_v + img_v + 10'd1 )))
					   ?  rom_dout : 8'b000_000_00;	

assign addr = ( count_v - ( pixel_v + 11'd1 )) * img_h + ( count_h - ( pixel_h + 10'd1 ));


endmodule
