module piso	(rst,parity_out,len,frame_out,parity_type,send, baud_out,data_out,p_parity_out,tx_active,tx_done);
input rst,send,baud_out,parity_out;
input [0:11] frame_out;
input [1:0] parity_type,len;
output reg p_parity_out,tx_active,tx_done;
output reg data_out;
reg [0:11]tmp;
reg [3:0] count,length;
always @(len)begin
case(len)
2'b00:length=9;
2'b01:length=10;
2'b10:length=11;
2'b11:length=12;
endcase
end
always @(parity_type,rst,parity_out) begin
if(rst==1'b1) p_parity_out<=0;
else begin
case(parity_type)
2'b00,2'b01,2'b10:p_parity_out<=0;
2'b11: p_parity_out<=parity_out;
endcase
end
end
always @(posedge baud_out,posedge rst)
begin
if(rst==1'b1) begin
count<=4'b1111;
tx_active<=1'b0;
tx_done<=1'b1;
end
else begin
if(send) begin
tmp<=frame_out;
count<=1;
data_out<=1'b0;
tx_active<=1'b1;
tx_done<=1'b0;
end
else begin
if(count<length) begin
data_out<=tmp[count];
count<=count+1;
end
else begin
data_out<=1'b1;
tx_active<=1'b0;
tx_done<=1'b1;
end
end
end
end
endmodule
