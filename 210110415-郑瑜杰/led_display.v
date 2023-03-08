module led_display (
    input wire clk,
    input wire reset,
    input wire  [1:0] failure_times,   //输入：密码匹配失败次数
    input wire success_input,           //输入：有效输入信号
    input wire [11:0]password_input,        //输入：所输入的密码
    input wire [2:0]input_count,             //输入：已输入按键的计数
    input wire [2:0]current_work_state,     //输入：当前的按键工作状态
    output reg [2:0]  red_led,          //输出：红色led灯 ：密码匹配错误提示信号
    output reg [2:0]  gre_led,          //输出：绿色led灯  ：输入有效 及 密码匹配成功信号
    output reg [7:0] led_en,            //输出数码管的使能信号
    output reg [7:0] led_cx             //输出数码管显示数字的信号
);   
parameter IDLE = 3'b000;
parameter seting_code =  3'b001;
parameter setcode_finish =  3'b010;
parameter inputing_password =  3'b011;
parameter match_success = 3'b100;
parameter freezed = 3'b101;

//count 2ms refresh moudule
reg[3:0]led_output;
reg [7:0]switch_led;
reg [19:0] refresh_cnt;
// wire refresh = (refresh_cnt == 20'd199_999);
wire refresh = (refresh_cnt == 20'd2);

always @(posedge clk or posedge reset) begin
    if(reset)   switch_led <=8'b1111_1110;
    else if(refresh)   switch_led <= {switch_led[0],switch_led[7:1]};
end

always @(posedge clk or posedge reset) begin
    if(reset |refresh) refresh_cnt<=0;
    else  refresh_cnt<=refresh_cnt+ 1;
end

//display red and green led
always @(*) begin
    case(failure_times)
        2'b00:red_led<=3'b000;
        2'b01:red_led<=3'b100;
        2'b10:red_led<=3'b110;
        2'b11:red_led<=3'b111;
        default:red_led<=0;
    endcase
end

always @(*) begin
    if(current_work_state==match_success) gre_led <= 3'b111;
    else if(success_input) gre_led<=3'b001;
    else gre_led<=3'b000;
end

//display digital led
always @ (*) begin
    if(current_work_state==freezed)
        led_output<=4'hf;
    else if(~((current_work_state==seting_code)|(current_work_state==inputing_password)))
        led_output <=4'h0;
    else begin
    if(input_count>display_place_num)begin
        case(display_place_num)
            2'd0:led_output<=password_input[11:8];
            2'd1:led_output<=password_input[7:4];
            2'd2:led_output<=password_input[3:0];
            default led_output<=0;
        endcase
         end
     else  led_output<=0;
    end       
end

always @(*) begin
    led_en <= switch_led;
end

reg [2:0]display_place_num;
always @(*) begin
    case(switch_led)
                8'b1111_1110:display_place_num <=3'd7;
                8'b1111_1101:display_place_num <=3'd6;
                8'b1111_1011:display_place_num <=3'd5;
                8'b1111_0111:display_place_num <=3'd4;
                8'b1110_1111:display_place_num <=3'd3;
                8'b1101_1111:display_place_num <=3'd2;
                8'b1011_1111:display_place_num <=3'd1;
                8'b0111_1111:display_place_num <=3'd0;
    endcase
end
always @(*) begin
        if((current_work_state==seting_code)|(current_work_state==inputing_password)) 
        begin//正在输入时
             if(input_count>display_place_num)begin  //显示已输入数字
             case(led_output)
            4'h0:led_cx <= 8'b0000_0011;
            4'h1:led_cx <= 8'b1001_1111;
            4'h2:led_cx <= 8'b0010_0101;
            4'h3:led_cx <= 8'b0000_1101;
            4'h4:led_cx <= 8'b1001_1001;
            4'h5:led_cx <= 8'b0100_1001;
            4'h6:led_cx <= 8'b0100_0001;
            4'h7:led_cx <= 8'b0001_1111;
            4'h8:led_cx <= 8'b0000_0001;
            4'h9:led_cx <= 8'b0001_1001;
            4'ha:led_cx <= 8'b0001_0001;
            4'hb:led_cx <= 8'b1100_0001;
            4'hc:led_cx <= 8'b1110_0101;
            4'hd:led_cx <= 8'b1000_0101;
            4'he:led_cx <= 8'b0110_0001;
            4'hf:led_cx <= 8'b0111_0001;
            endcase
            end
            else   led_cx <= 8'b1111_1111;//不显示其他灯
       end
       else begin  //非输入数据状态，所有灯都亮
             case(led_output)
            4'h0:led_cx <= 8'b0000_0011;
            4'h1:led_cx <= 8'b1001_1111;
            4'h2:led_cx <= 8'b0010_0101;
            4'h3:led_cx <= 8'b0000_1101;
            4'h4:led_cx <= 8'b1001_1001;
            4'h5:led_cx <= 8'b0100_1001;
            4'h6:led_cx <= 8'b0100_0001;
            4'h7:led_cx <= 8'b0001_1111;
            4'h8:led_cx <= 8'b0000_0001;
            4'h9:led_cx <= 8'b0001_1001;
            4'ha:led_cx <= 8'b0001_0001;
            4'hb:led_cx <= 8'b1100_0001;
            4'hc:led_cx <= 8'b1110_0101;
            4'hd:led_cx <= 8'b1000_0101;
            4'he:led_cx <= 8'b0110_0001;
            4'hf:led_cx <= 8'b0111_0001;
            endcase
       end
end
endmodule