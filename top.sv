//top block

module top;

bit clk;

always #5 clk=~clk;

inter i1(clk);
test i2(i1);
design_4bitSR i3(.clk(clk),.reset(i1.reset),.dir(i1.dir),.load(i1.load),.serial_in(i1.serial_in),.parallel_in(i1.parallel_in),.serial_out(i1.serial_out),.parallel_out(i1.parallel_out));



initial
begin
	$dumpfile("4BIT_SHIFT_REG.vcd");
	$dumpvars;
end
endmodule
