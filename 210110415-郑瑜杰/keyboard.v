module keyboard #(
    parameter CNT_THRESHOLD=1000000-1
)(
    input  wire       clk,
    input  wire       reset,
    input  wire [3:0] row,           
    output reg  [3:0] col,           
    output reg        keyboard_en,   //keyboard的使能信号
    output reg  [3:0] keyboard_num_buffer  //将输入的数字用一个缓冲区存储起来，并作为输出信号
);
reg  [3:0] keyboard_num;//某一使能瞬间键盘的数字
wire cnt_end;

counter #(CNT_THRESHOLD, 24) u_counter( //计数器
    .clk(clk), 
    .reset(reset), 
    .cnt_inc(1),
    .cnt_end(cnt_end)
);

reg[15:0] key;
reg[15:0] key_r;
wire[15:0] key_posedge = (~key_r) & key;  

always @(posedge clk, posedge reset) begin
    if (reset == 1) begin
        keyboard_num <= 0;   
    end else if (key_posedge) begin
		if (key_posedge[0]) keyboard_num <= 'hd;
		else if (key_posedge[1]) keyboard_num <= 'hc;
		else if (key_posedge[2]) keyboard_num <= 'hb;
		else if (key_posedge[3]) keyboard_num <= 'ha;
		else if (key_posedge[4]) keyboard_num <= 'hf;
		else if (key_posedge[5]) keyboard_num <= 'h9;
		else if (key_posedge[6]) keyboard_num <= 'h6;
		else if (key_posedge[7]) keyboard_num <= 'h3;
		else if (key_posedge[8]) keyboard_num <= 'h0;
		else if (key_posedge[9]) keyboard_num <= 'h8;
		else if (key_posedge[10]) keyboard_num <= 'h5;
		else if (key_posedge[11]) keyboard_num <= 'h2;
		else if (key_posedge[12]) keyboard_num <= 'he;
		else if (key_posedge[13]) keyboard_num <= 'h7;
		else if (key_posedge[14]) keyboard_num <= 'h4;
		else if (key_posedge[15]) keyboard_num <= 'h1;
	end else begin
		keyboard_num <= 0;
	end
end

//将按键的数字缓存下来
always @(posedge clk, posedge reset) begin
        if (reset == 1) begin
        keyboard_num_buffer <= 0;   
        end
        else begin
            if(keyboard_en)
            keyboard_num_buffer <= keyboard_num;
        end
end

always @(posedge clk, posedge reset) begin
    if (reset == 1) begin
        keyboard_en <= 0;
    end else if (key_posedge) begin
		keyboard_en <= 1;
	end else begin
		keyboard_en <= 0;
	end
end

//自左向右扫描
always @(posedge clk, posedge reset) begin
    if (reset == 1)           col <= 4'b1111;
    else if (col ==  4'b1111) col <= 4'b0111;
    else if (cnt_end)         col <= {col[0], col[3:1]};
end

always @(posedge clk, posedge reset) begin
    if (reset == 1) key_r <= 0;
    else key_r <= key;
end

always @(posedge clk, posedge reset) begin
    if (reset == 1) key <= 0;
    else if (cnt_end) begin
        if (col[0] == 0) key[3:0]   <= ~row;
        if (col[1] == 0) key[7:4]   <= ~row;
        if (col[2] == 0) key[11:8]  <= ~row;
        if (col[3] == 0) key[15:12] <= ~row;
    end
end

endmodule