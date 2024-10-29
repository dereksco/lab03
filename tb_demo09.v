`timescale  1ns/1ns
module  tb_demo09();
//reg   define
reg         sys_clk;
reg         sys_rst_n;
reg         pi_money_one;
reg         pi_money_half;
reg         random_data_gen;
//wire  define
wire        po_cola;
wire        po_money;
//初始化系统时钟、全局复位
initial begin
    sys_clk    = 1'b1;
    sys_rst_n <= 1'b0;
    #20
    sys_rst_n <= 1'b1;
end
//sys_clk:模拟系统时钟，每10ns电平翻转一次，周期为20ns，频率为50MHz
always  #10 sys_clk = ~sys_clk;

//random_data_gen:产生非负随机数0、1
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        random_data_gen <= 1'b0;
    else
        random_data_gen <= {$random} % 2;

//pi_money_one:模拟投入1元的情况
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        pi_money_one <= 1'b0;
    else
        pi_money_one <= random_data_gen;

//pi_money_half:模拟投入0.5元的情况
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        pi_money_half <= 1'b0;
    else
    //取反是因为一次只能投一个币，即pi_money_one和pi_money_half不能同时为1
        pi_money_half <= ~random_data_gen;

wire    [4:0]   state    = demo09_inst.state;
wire    [1:0]   pi_money = demo09_inst.pi_money;

initial begin
    $timeformat(-9, 0, "ns", 6);
    $monitor("@time %t: pi_money_one=%b pi_money_half=%b pi_money=%b state=%b po_cola=%b po_money=%b", $time, pi_money_one, pi_money_half, pi_money, state, po_cola, po_money);
end
demo09 demo09_inst(
    .sys_clk        (sys_clk        ),  //input     sys_clk
    .sys_rst_n      (sys_rst_n      ),  //input     sys_rst_n
    .pi_money_one   (pi_money_one   ),  //input     pi_money_one
    .pi_money_half  (pi_money_half  ),  //input     pi_money_half
                    
    .po_cola        (po_cola        ),  //output    po_money
    .po_money       (po_money       )   //output    po_cola
);  

endmodule