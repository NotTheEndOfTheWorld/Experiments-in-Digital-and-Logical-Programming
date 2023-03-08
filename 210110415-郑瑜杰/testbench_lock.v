`timescale 1ns/1ps         
//`include "lock.v"
//`include "counter.v"
module lock_sim();    


//input
reg        clk;
wire        reset;
wire         set_code_button;
wire         confirm_button;
wire         input_button;
wire  [3:0] row;

//output
wire [3:0] col;
wire [7:0] led_en;
wire  [7:0] led_cx;
wire  [2:0]  gre_led;
wire  [2:0]  red_led;

wire        cnt_end;
// reg [7:0] keycase_cnt;   //������������
// wire keycase_inc;

parameter CNT_THRESHOLD=5;

// counter #(CNT_THRESHOLD, 24) u_test_counter(     //��������ʱ��ƥ���row�ź�
//     .clk(clk), 
//     .reset(reset), 
//     .cnt_inc(1), 
//     .cnt_end(cnt_end)
// );

lock #(CNT_THRESHOLD) u_lock(   
    .clk(clk), 
    .reset(reset), 
    .set_code_button(set_code_button),
    .confirm_button(confirm_button),
    .input_button(input_button),
    .row(row), 
    .col(col), 
    .red_led(red_led),
    .gre_led(gre_led),
    .led_cx(led_cx),
    .led_en(led_en)
);
   
always #5 clk = ~clk;

reg [7:0]switch;
initial begin
    clk=0;
    switch = 8'b1_0_0_0_1111;
    # 10

//set 123
    switch = 8'b0_1_0_0_0111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));


    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_0111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_0111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));


    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_1_0_1111; //finish input 
    #(10*(CNT_THRESHOLD+1));


    //test 111
    switch = 8'b0_0_0_1_0111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));


    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));

    
    switch = 8'b0_0_0_0_0111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));

    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));


    switch = 8'b0_0_0_0_0111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_1_0_1111;  //finish input 
    #(10*(CNT_THRESHOLD+1));

    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));



    //test 123
    switch = 8'b0_0_0_1_0111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));


    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_0111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_0111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));


    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_1_0_1111; //finish input 
    #(10*(CNT_THRESHOLD+1));


//set AB7
    switch = 8'b0_1_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_0111;
    #(10*(CNT_THRESHOLD+1));


    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1011;
    #(10*(CNT_THRESHOLD+1));


    switch = 8'b0_0_0_0_1101;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_1_0_1111; //finish input 
    #(10*(CNT_THRESHOLD+1));


    //test 123
    switch = 8'b0_0_0_1_0111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));


    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_0111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_0111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));


    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_1_0_1111; //finish input 
    #(10*(CNT_THRESHOLD+1));


    //test AB1
    switch = 8'b0_0_0_1_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_0111;
    #(10*(CNT_THRESHOLD+1));


    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1011;
    #(10*(CNT_THRESHOLD+1));


    switch = 8'b0_0_0_0_0111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_1_0_1111; //finish input 
    #(10*(CNT_THRESHOLD+1));


    //test AC7
    switch = 8'b0_0_0_1_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_0111;
    #(10*(CNT_THRESHOLD+1));


    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1101;
    #(10*(CNT_THRESHOLD+1));


    switch = 8'b0_0_0_0_1101;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_1_0_1111; //finish input 
    #(10*(CNT_THRESHOLD+1));


    //test AB7
    switch = 8'b0_0_0_1_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_0111;
    #(10*(CNT_THRESHOLD+1));


    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1011;
    #(10*(CNT_THRESHOLD+1));


    switch = 8'b0_0_0_0_1101;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_0_0_1111;
    #(10*(CNT_THRESHOLD+1));
    switch = 8'b0_0_1_0_1111; //finish input 
    #(10*(CNT_THRESHOLD+1));






    # 100
    $finish;
end

assign {reset , set_code_button,  confirm_button,  input_button,  row  }=switch;

// assign keycase_inc = cnt_end;

// always @(posedge clk, posedge reset) begin
//     if (reset) keycase_cnt <= 0;
//     else if (keycase_inc) keycase_cnt <= keycase_cnt + 1;
// end


// always @(*) begin
//     case(keycase_cnt[7:2])  //ÿ��4��ɨ�裬ȥ����2λ���ڼ���������������
//         8'b0000_00:
//             if(col==4'b1110) row = 4'b1110;  // �����ұߵ�һ�а�������
//             else row = 4'b1111;
//         8'b0000_01: 
//             if(col==4'b1110) row = 4'b1101;
//             else row = 4'b1111;
//         8'b0000_10:
//             if(col==4'b1110) row = 4'b1011;
//             else row = 4'b1111;
//         8'b0000_11: 
//             if(col==4'b1110) row = 4'b0111;
//             else row = 4'b1111;      
//         8'b0001_00:                           //�����ұߵڶ��а�������
//             if(col==4'b1101) row = 4'b1110;
//             else row = 4'b1111;
//         8'b0001_01:
//             if(col==4'b1101) row = 4'b1101;
//             else row = 4'b1111;
//         8'b0001_10: 
//             if(col==4'b1101) row = 4'b1011;
//             else row = 4'b1111; 
//         8'b0001_11: 
//             if(col==4'b1101) row = 4'b0111;
//             else row = 4'b1111; 
//         default:
//             row = 4'b1111; 
//     endcase
// end
   
endmodule

