# code for fifo.v
  ...
     module fifo(clk,rst,we,re,d_in,d_out,empty,full);
        input clk,rst,we,re;
        input [7:0]d_in;
        output reg [7:0]d_out;
        output empty,full;

        reg [4:0]wptr,rptr;

        reg [7:0]mem[15:0];

        always@(posedge clk)
        begin
                if(rst)
                        wptr<=0;
                else if(we && !full)
                begin
                        mem[wptr]<=d_in;
                        wptr<=wptr+1;
                end
        end

        always@(posedge clk)
        begin
                if(rst)
                begin
                        d_out<=0;
                        rptr<=0;
                end
                else if(re && !empty)
                begin
                        d_out<=mem[rptr];
                        rptr<=rptr+1;
                end
        end

        assign empty=(rptr==wptr)? 1'b1:1'b0;
        assign full=(rptr[4]!==wptr[4])&&(rptr[3:0]==wptr[3:0]);
        endmodule
...
