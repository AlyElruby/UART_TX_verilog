module frame_gen(input rst, input [7:0]data_in, input parity_out, input[1:0] parity_type,input stop_bits, input data_length,output reg[0:11]frame_out,output reg[1:0] len);

reg [1:0]Sel=0;
/*
Len=00 Length=9
Len=01 Length=10
Len=10 Length=11
Len=11 Length=12
*/
always @(*)
begin
  Sel={stop_bits,data_length};
  if(!rst)
  begin
  case (Sel)
     2'b00:
	  begin
	    if(parity_type==2'b01||parity_type==2'b10)
		   begin
		   frame_out<={1'b0,data_in[6:0],parity_out,1'b1,2'b11};//Length =10
		   len<=2'b01;	
			end
		 else 
		   begin
		   frame_out<={1'b0,data_in[6:0],1'b1,3'b11};//Length =9 
			len<=2'b00;
			end
	  end
     2'b01:
	  begin
	    if(parity_type==2'b01||parity_type==2'b10)
		   begin
		   frame_out<={1'b0,data_in,parity_out,1'b1,1'b1};//Length =11
			len<=2'b10;
			end
		 else 
		   begin
		   frame_out<={1'b0,data_in,1'b1,2'b11};//Length =10
			len<=2'b01;
			end
	  end
	  2'b10:
	  begin
	    if(parity_type==2'b01||parity_type==2'b10)
		   begin
		   frame_out<={1'b0,data_in[6:0],parity_out,2'b11,1'b1};//Length =11
			len<=2'b10;
			end
		 else 
		   begin
		   frame_out<={1'b0,data_in[6:0],2'b11,2'b11};//Length =10
			len<=2'b01;
			end
	  end
     2'b11:
	  begin
	    if(parity_type==2'b01||parity_type==2'b10)
		   begin
		   frame_out<={1'b0,data_in,parity_out,2'b11};// Length=12
			len<=2'b11;
			end
		 else 
		   begin
		   frame_out<={1'b0,data_in,2'b11,1'b1};//Length =11 
			len<=2'b10;
			end
	  end
  endcase
  end
  else begin
	   frame_out<=12'b0;
		len<=2'b0;
		end
end
endmodule