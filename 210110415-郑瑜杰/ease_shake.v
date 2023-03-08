module ease_shake#(
    parameter CNT_THRESHOLD=1000000-1
)(
    input         clk,
    input         reset, 
    input   wire   button,       //输入所需消抖按键
    output  reg    effect_button    //输出上升沿
);

wire cnt_end;

counter #(CNT_THRESHOLD-2, 24) u_counter(   //计数器
    .clk(clk), 
    .reset(reset), 
    .cnt_inc(1),
    .cnt_end(cnt_end)
);

reg r_button;
always @(posedge clk ) begin
    if(cnt_end)
        r_button<=button;
end

always @(*) begin
    effect_button <= (~r_button) & button;  
end
endmodule
