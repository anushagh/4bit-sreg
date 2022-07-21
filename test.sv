//test module
//`include "driver.sv"

class transactor;

rand bit serial_in;
rand bit [3:0] parallel_in;
rand bit dir,load;

endclass

class driver;

transactor trx;
virtual inter.TB T1;

function new(virtual inter.TB T2);
begin
	this.T1=T2;
	this.trx=new();
end
endfunction

task drive_data();
begin
	repeat(100) @(T1.cb)
	begin
		if((trx.randomize()))
		begin
			T1.cb.serial_in <= trx.serial_in;
			T1.cb.dir<= trx.dir;
			T1.cb.parallel_in<=trx.parallel_in;
			T1.cb.load<=trx.load;
			//$display("%d : driver: sent A=%b, B=%b and opcode=%b",$time, i1.cb.a,i1.cb.b,i1.cb.opcode);
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
	T3.reset <= 0;
	#10 T3.reset <=1;
	#10 T3.reset <=0;
	#1000 $finish;
end

initial
begin
	driver drv;
	drv=new(T3);
	drv.drive_data();
end

endprogram
