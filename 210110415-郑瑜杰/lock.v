module lock#(
    parameter CNT_THRESHOLD=1000000-1
)(
    input         clk,                  //输入：时钟信号
    input         reset,                //输入：复位信号
    input         set_code_button,      //输入：设置密码按键
    input         confirm_button,       //输入：确认输入按键
    input         input_button,         //输入：输入验证密码按键
    input  [3:0]  row,                   //输入：键盘的行信号
    output [3:0]  col,                  //输出：键盘的列信号
    output [2:0]  red_led,              //输出：红色led灯 ：密码匹配错误提示信号
    output [2:0]  gre_led,              //输出：绿色led灯  ：输入有效 及 密码匹配成功信号
    output reg [7:0] led_en,        //输出数码管的使能信号
    output reg [7:0] led_cx         //输出数码管显示数字的信号
);
wire  keyboard_en;          //键盘使能
wire [3:0]keyboard_num;     //键盘输入的数字
keyboard #(CNT_THRESHOLD)u_keyboard(
    .clk(clk), 
    .reset(reset), 
    .row(row), 
    .col(col), 
    .keyboard_en(keyboard_en),   
    .keyboard_num_buffer(keyboard_num)    
);

wire effect_confirm_button;   //消抖后的上升沿确认键
ease_shake  #(CNT_THRESHOLD)u_ease_shake(
    .clk(clk),
    .reset(reset),
    .button(confirm_button),
    .effect_button(effect_confirm_button)
);
wire [11:0]password_input;      //输入的密码
wire   [1:0] failure_times;     //密码匹配错误次数
wire         success_input;     //输入是否有效
wire          match;            //匹配情况
wire  [2:0]input_count;         //输入计数
wire [2:0]current_work_state_0;//当前工作状态
main_work u_main_work(
    .clk(clk),
    .reset(reset),
    .set_code_button(set_code_button),
    .input_button(input_button),
    .confirm_button(effect_confirm_button),
    .keyboard_en(keyboard_en),
    .keyboard_num(keyboard_num),
    .failure_times(failure_times),
    .success_input(success_input),
    .password_input(password_input),
    .match(match),
    .input_count(input_count),
    .current_work_state(current_work_state_0)
);

wire [7:0]led_en_0;
wire [7:0]led_cx_0;
always@(*)begin
    led_en<=led_en_0;
    led_cx<=led_cx_0;
end
led_display u_led_display(
    .clk(clk),
    .reset(reset),
    .success_input(success_input),
    .failure_times(failure_times),
    .red_led(red_led),
    .gre_led(gre_led),
    .led_en(led_en_0),
    .led_cx(led_cx_0),
    .password_input(password_input),
    .input_count(input_count),
    .current_work_state(current_work_state_0)
);
endmodule
