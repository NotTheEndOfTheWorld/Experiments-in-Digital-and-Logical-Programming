module main_work (
    input  wire       clk,
    input  wire       reset,
    input         set_code_button,      //输入：设置密码按键
    input         confirm_button,       //输入：确认输入按键
    input         input_button,         //输入：输入验证密码按键
    input  wire        keyboard_en,   //keyboard的使能信号
    input  wire  [3:0] keyboard_num,  //键盘输入的数字
    output reg   [1:0] failure_times,   //输出：密码匹配失败次数
    output reg         success_input,   //输出：有效输入信号
    output reg      [11:0]password_input,//输出：所输入的密码缓冲区
    output reg          match,          //输出：匹配成功信号
    output reg [2:0]input_count,        //输出：已输入按键的计数
    output reg [2:0]current_work_state      //输出：当前的按键工作状态
);
wire [11:0]password_set;
//连线
wire [11:0]password_input_0;
wire success_input_0;
wire [1:0] failure_times_0;
wire [2:0]input_count_0;
wire match_0;
wire [2:0]current_work_state_0;
always@(*) begin
    password_input <= password_input_0;
    success_input <= success_input_0;
    failure_times <=failure_times_0;
    input_count<=input_count_0;
    match<=match_0;
    current_work_state<=current_work_state_0;
end
memorize u_memorize(
    .clk(clk),
    .reset(reset),
    .set_code_button(set_code_button),
    .confirm_button(confirm_button),
    .input_button(input_button),
    .keyboard_en(keyboard_en),
    .keyboard_num(keyboard_num),
    .password_input(password_input_0),
    .password_set(password_set),
    .match(match_0),
    .success_input(success_input_0),
    .failure_times(failure_times_0),
    .input_count(input_count_0),
    .current_work_state(current_work_state_0)
);

//match code 
match_code_state_machine u_match_code_state_machine(
    .clk(clk),
    .reset(reset),
    .confirm_button(confirm_button),
    .input_button(input_button),
    .set_code_button(set_code_button),
    .password_input(password_input_0),
    .password_set(password_set),
    .match(match_0),
    .failure_times(failure_times_0)
);
endmodule