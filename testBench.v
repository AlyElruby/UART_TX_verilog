`timescale 10 ps/1 ps
module uart_tx_tb;
    reg 		clock, rst, send;
	reg [7:0] data_in;
	reg [1:0] parity_type; 	
	reg		stop_bits; 		
	reg 		data_length; 	
	
	wire 	data_out; 		
	wire  	p_parity_out; 	
	wire  	tx_active; 		
	wire 	    tx_done; 	
    
    uart_tx test(clock,rst,send,data_in,parity_type,stop_bits,data_length,data_out,p_parity_out,tx_active,tx_done);
    initial 
    begin
        clock=0;
        forever #5 clock=~clock;
    end
    initial
    begin
    rst=0;
    #10 rst=1;
    #10 rst=0;
    send=0;stop_bits=0;data_length=0;
    parity_type=2'b01;data_in=8'b10010110;
    #10 send=1; #10 send=0;
    #100 data_length=1; send=1;  
    end
    initial
    $monitor("data_out= %b    ,p_parity_out= %b     ,tx_active= %b     ,tx_done= %b \n",data_out,p_parity_out,tx_active,tx_done);
    endmodule