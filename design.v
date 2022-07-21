//design of 4 bit shift register

module design_4bitSR(input clk,reset,dir,load,serial_in,input [3:0]parallel_in,output reg serial_out,output [3:0]parallel_out);

reg [3:0]temp_po;
reg [3:0]temp_so;
always@(posedge clk,posedge reset)
begin
	if(reset) temp_po<=4'b0;
	else
	begin
		case(dir)
		1'b0:temp_po<={temp_po[3:1],serial_in};	//SIPO
		1'b1: //PISO
			begin
				if(load)
				begin
					temp_so<=parallel_in;
				end
				else
				begin
					serial_out<=temp_so[3];
					temp_so<={temp_so[2:0],1'b0};
				end
			end
		default: 
			begin
				temp_po <=1'bx;
			end
		endcase	
	end	
end
assign parallel_out = temp_po;

endmodule
