//interface block
interface inter(input bit clk);

logic reset,dir,load,serial_in,serial_out;
logic [3:0]parallel_out,parallel_in;


clocking cb @(posedge clk);
default input #2ns output #3ns;
input parallel_out,serial_out;
output dir,load,serial_in,parallel_in;
endclocking

modport TB(clocking cb,output reset);

endinterface
