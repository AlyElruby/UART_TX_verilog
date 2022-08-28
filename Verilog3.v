module baud_gen(
input rst,clock,
input [1:0] baud_rate,
output reg baud_out);
reg [14:0] count=15'd0;
reg [14:0] divid;
always @(baud_rate)
begin
case(baud_rate)
	2'b00:
	begin
		divid<=15'd20833;
		  end
	2'b01:
	begin
		divid<=15'd10417;
		  end	  
	2'b10:
	begin
		divid<=15'd5208;
		  end	  
	2'b11:
	begin
		divid<=15'd2604;
		  end	  
	endcase 
end
always@(posedge clock,posedge rst)
begin
if(rst) 
begin
count<=15'd0;
baud_out <= 0;
end
else
begin
		if(count<=(divid-1))
		begin
		baud_out <= (count<divid/2)?1'b1:1'b0;
		count<=count+1;
		end
		else
		begin
		count<=0;
		end
end
end
endmodule  