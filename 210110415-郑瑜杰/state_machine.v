module match_code_state_machine(
    input         clk,
    input         reset,
    input         confirm_button,   //输入：确认输入按键
    input         set_code_button, //输入：设置密码按键
    input         input_button,     //输入：输入验证密码按键
    input   [11:0]password_set,   //输入：所设置的密码
    input  [11:0]password_input,   //输入：所输入的密码
    input  [1:0]failure_times,      //输出：密码匹配失败次数
    output reg     match         //输出：匹配成功信号
);
//match_code_state machine
parameter IDLE = 3'b000;   //初始状态
parameter s0 =  3'b001;     //开始匹配状态
parameter s1 =  3'b010;     //第一位密码匹配成功
parameter s2 =  3'b011;     //第二位密码匹配成功
parameter s3 = 3'b100;      //第三位密码匹配成功
reg [2:0] current_state;
reg [2:0] next_state;
reg setcode;

always @(posedge clk or posedge reset) begin
    if(reset) setcode <=0;
    else begin
        if(set_code_button) setcode <=1;
        // else if(confirm_button) setcode <=0;
    end
end
//state machine 

always @(posedge clk or posedge reset) begin
    if(reset|input_button) current_state <=IDLE;
    else        current_state <= next_state;
end

always @(*) begin
    if(reset) next_state <=IDLE;
    else if(failure_times!=2'd3)begin
    case (current_state)
         IDLE : if(input_button) next_state <= s0;
               else next_state<=next_state;
         s0 : if(password_input[11:8]==password_set[11:8]) next_state <= s1;
            else next_state<=s0;
         s1 : if(password_input[7:4]==password_set[7:4]) next_state <= s2;
            else next_state<=s0;
         s2 : if(password_input[3:0]==password_set[3:0]) next_state <= s3;
            else next_state<=s0;
         s3 : if(confirm_button) next_state<=IDLE;
            else next_state<=s3;
         default:next_state <= IDLE;
    endcase
    end
end

always @(posedge clk or posedge reset) begin
    if(reset | input_button) match <= 0;
    else begin
        if(~setcode) match <=0;
        else if(current_state==s3&confirm_button)
            match <= 1'b1;
    end
end

endmodule
