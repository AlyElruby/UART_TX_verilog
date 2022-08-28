module parity (
input rst,
input [7:0] data_in,
input [1:0] parity_type,
output reg parity_out
);
integer count,i;
always @(*)
begin
count=0;
i=0;
if(rst==1)
parity_out<=0;
else
begin
for(i=0; i<=7; i=i+1)
    begin
        if(data_in[i]==1)
        count = count + 1;
    end
	 case(parity_type)
		2'b00://no parity
		begin
			parity_out <= 0;
		end
		2'b01,2'b11:
		begin
			if(count%2==0)  //odd parity
			 parity_out <= 1;
			 else
			 parity_out <= 0;
		end
		2'b10:
		begin
			if(count%2==0)  //even parity
			 parity_out <= 0;
			 else
			 parity_out <= 1;
		end
endcase
end
end
endmodule