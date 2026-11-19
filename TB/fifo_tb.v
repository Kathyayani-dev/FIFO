# code for  fifo_tb.v
  ...
     
     module fifo_tb();
        reg clk,rst,we,re;
        reg [7:0]d_in;
        wire [7:0]d_out;
        wire full,empty;

        //integer l;

        fifo DUT(clk,rst,we,re,d_in,d_out,empty,full);

        parameter CYCLE=10;

        always
        begin
                #(CYCLE/2);
                clk=1'b0;
                #(CYCLE/2);
                clk=~clk;
        end

        task initialize;
                begin
                        d_in=0;
                end
        endtask

        task rst_dut;
                begin
                        @(negedge clk);
                        rst=1'b1;
                        @(negedge clk);
                        rst=1'b0;
                end
        endtask

   task stimulus(input [7:0]i);
                begin
                @(negedge clk);
                        d_in=i;
                end
   endtask

        task delay();
                begin
                        #10;
                end
        endtask

        task write();
                begin
                        we=1'b1;
                        re=1'b0;
                end
        endtask

        task read();
                begin
                        re=1'b1;
                        we=1'b0;
                end
        endtask


                initial
                begin
                        initialize;
                        rst_dut;
                        write;

                        begin
                        stimulus(8'hab);
                        stimulus(8'ha4);
                        stimulus(8'he1);
                        stimulus(8'hb3);

                        stimulus(8'hab);
                        stimulus(8'ha4);
                        stimulus(8'he1);
                        stimulus(8'hb3);

                        stimulus(8'hab);
                        stimulus(8'ha4);
                        stimulus(8'he1);
                        stimulus(8'hb3);

                        stimulus(8'hab);
                        stimulus(8'ha4);
                        stimulus(8'he1);
                        stimulus(8'hb3);

                        delay;

                        read;
                        /*for(l=0;l<16;l=l+1)
                        begin
                                delay;
                        end
                        //repeat(3)
                        delay;*/
                end
                end
endmodule
...                          
