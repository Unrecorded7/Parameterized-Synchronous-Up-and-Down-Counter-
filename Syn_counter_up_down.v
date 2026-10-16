module top #(
    parameter width=4
) (
    input clk,
    input reset,
    input preset,
    input ud,
    output reg [width-1:0] q
);

always @(posedge clk ) begin
    if(reset)
        q<=0;
    else if(preset)
        q<={width{1'b1}};
    else begin
        if(ud)
            q<=q+1'b1;
        else 
            q<=q-1'b1; 
    end

end



endmodule