module memorize(
    input  wire       clk,
    input  wire       reset,
    input  wire      set_code_button,   //输入：设置密码按键
    input  wire       confirm_button,       //输入：确认输入按键
    input  wire       input_button,         //输入：输入验证密码按键
    input wire        keyboard_en,   //keyboard的使能信号
    input wire  [3:0] keyboard_num,  //键盘输入的数字
    output reg [11:0]password_set,   //输出：所设置的密码=
    output reg [11:0]password_input,  //输出：所输入的密码缓冲区
    output reg [1:0]failure_times,   //输出：密码匹配失败次数
    output reg        success_input, //输出：有效输入信号
    output reg [2:0]input_count,    //输出：已输入按键的计数
    output reg [2:0] current_work_state, //输出：当前的按键工作状态
    input wire        match        //输入：匹配成功信号
);
//working state machine
parameter IDLE = 3'b000;            //初始状态
parameter seting_code =  3'b001;    //设置密码状态
parameter setcode_finish =  3'b010; //完成密码设置状态
parameter inputing_password =  3'b011;//验证输入密码状态
parameter match_success = 3'b100;       //匹配成功状态
parameter freezed = 3'b101;             //冻结锁住状态
reg [2:0] next_work_state;
always @(posedge clk or posedge reset) begin
    if(reset) current_work_state <=IDLE;
    else        current_work_state <= next_work_state;
end
//功能状态转移
always @(*) begin
    if(reset) next_work_state <=IDLE;
    case (current_work_state)
         IDLE : if(set_code_button) next_work_state <= seting_code;
               else next_work_state<=next_work_state;
         seting_code : if(confirm_button&input_count==3) next_work_state <= setcode_finish;
            else next_work_state<=next_work_state;
         setcode_finish : if(input_button) next_work_state <= inputing_password;
            else next_work_state<=next_work_state;
         inputing_password : if(match) next_work_state <= match_success;
            else if(success_input&failure_times==2) next_work_state <= freezed;
            else if(success_input&failure_times<2)next_work_state <= setcode_finish;
            else next_work_state<=next_work_state;
         match_success : if(set_code_button) next_work_state<=seting_code;
            else if(input_button) next_work_state<=inputing_password;
            else next_work_state<=next_work_state;
         freezed : if(reset) next_work_state<=IDLE;
            else next_work_state<=next_work_state;
         default:next_work_state <= IDLE;
    endcase
end
//密码错误失败计数
always @(posedge clk or posedge reset) begin
    if(reset) failure_times<=0;
    else if(current_work_state==inputing_password &success_input )begin
        if(match) failure_times<=0;
        else failure_times<=failure_times + 2'b01;
    end
end
reg setcode;//是否设置好密码了
//deal with input and memorize
always @(posedge clk or posedge reset) begin
    if(reset) setcode<=1'b0;
    else if(current_work_state==seting_code)
        begin
            if((~setcode | match) & confirm_button)begin
            setcode <=1'b1;
            end
        end
end
//输入的计数
always @ (posedge clk or posedge reset) begin
    if(reset)   input_count<=0;
    else begin
        if(input_button|confirm_button|set_code_button) input_count<=0;
        else if(keyboard_en)begin
            input_count <=input_count+ 1;
        end
    end
end
//密码的输入
always @ (posedge clk or posedge reset) begin
    if(reset) password_input<=0;
    else begin
    if(set_code_button|input_button) password_input<=0; //清除上一次输入
    else begin
            case(input_count)
            3'b001 : password_input[11:8]<= keyboard_num;
            3'b010 : password_input[7:4] <= keyboard_num;
            3'b011 : password_input[3:0] <= keyboard_num;
            default: password_input <= password_input;
            endcase
          end
    end
end
//密码设置
always @ (posedge clk or posedge reset) begin
    if(reset)   password_set<=0;
    else begin
        if(current_work_state==seting_code| current_work_state==match_success)
        begin
            if((~setcode | match) & confirm_button)begin
            password_set <=password_input;
            end
        end
    end
end

//输入有效信号
always @(posedge clk or posedge reset) begin
    if(reset) success_input<=0 ;
    else if (confirm_button )begin
        if(input_count ==3'b011 &(failure_times!=2'b11))
        success_input<=1'b1;
        else success_input<=1'b0;
    end
end

endmodule
