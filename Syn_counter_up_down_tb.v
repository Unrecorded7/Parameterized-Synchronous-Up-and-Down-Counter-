`timescale 1ns/100ps
module tb;
    parameter width=4;
    reg clk;
    reg ud;
    reg reset;
    reg preset;
    wire [width-1:0]q;

top#(.width(width)) t1(
    .clk(clk),
    .ud(ud),
    .reset(reset),
    .preset(preset),
    .q(q)
);
initial clk=0;
always #5 clk=~clk;
integer i;
reg [width-1:0]expected;
task test_step ;
    input reset_i;
    input preset_i;
    input ud_i;
    begin
        @(negedge clk);
        reset=reset_i;
        preset=preset_i;
        ud=ud_i;
        
    
    @(posedge clk) ;

    if(reset_i)
        expected=0;
    else if(preset_i)
        expected={width{1'b1}};
    else if(ud_i)
        expected=expected+1'b1;
    else 
        expected=expected-1'b1;
     #1 ;
        if(q!==expected)begin
         $display("FAIL: reset=%b preset=%b ud=%b expected=%0d actual=%0d",reset_i, preset_i, ud_i, expected, q);
        $finish;
        end
        else begin
            $display("PASS: expected=%0d actual=%0d",expected, q);  
        end
    end
endtask
    
initial begin
    $dumpfile("counter.vcd");
    $dumpvars(0,tb);
    reset=0;
    preset=0;
    ud=1;
    expected=0;

    test_step(1,0,1);
    test_step(1,0,1);
    test_step(0,1,1);

        test_step(0, 0, 1);  // 15 -> 0 (up wraparound)
        test_step(0, 0, 1);  // 0 -> 1
        test_step(0, 0, 1);  // 1 -> 2

        test_step(0, 1, 1);  // Preset -> 15
        test_step(0, 0, 0);  // 15 -> 14
        test_step(0, 0, 0);  // 14 -> 13

        test_step(1, 1, 0);  // Reset priority -> 0
        test_step(0, 0, 0);  // 0 -> 15 (down wraparound)
        test_step(0, 0, 0);  // 15 -> 14

        $display("ALL TESTS PASSED");
        $finish;

end
endmodule