//test module
//`include "driver.sv"

class transactor;

rand bit sl_in;
rand bit [3:0] pl_in;
rand bit d,load;

endclass

class driver;
transactor tx;
virtual inter.TB T1;

function new(virtual inter.TB T2);
begin
	this.T1=T2;
	this.tx=new();
end
endfunction

task drive();
begin
	repeat(100) @(T1.cb)
	begin
		if((tx.randomize()))
		begin
			T1.cb.s_in <= tx.sl_in;
			T1.cb.d<= tx.d;
			T1.cb.p_in<=tx.pl_in;
			T1.cb.load<=tx.load;
		end
		else
		$display("error encountered");
	end
end
endtask

endclass


program test(inter.TB T3);

initial
begin
	T3.reset <= 1;
	#10 T3.reset <= 0;
	#100 T3.reset <=1;
	#100 T3.reset <=0;
	#1000 $finish;
end

initial
begin
	driver drv;
	drv=new(T3);
	drv.drive();
end

endprogram
