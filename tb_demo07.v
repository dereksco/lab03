`timescale 1ns / 1ps

module tb_demo07;

    // 测试平台信号
    reg clk;         // 时钟信号
    reg rst_n;      // 异步复位信号
    reg d;          // 数据输入
    wire q;         // 数据输出

    // 实例化异步D触发器
    demo07 uut (
        .clk(clk),
        .rst_n(rst_n),
        .d(d),
        .q(q)
    );

    // 时钟生成
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 每5个时间单位翻转一次
    end

    // 测试过程
    initial begin
        // 初始化信号
        rst_n = 1; // 复位信号初始为高
        d = 0;     // 数据输入初始为0

        // 等待一段时间
        #10;

        // 测试异步复位
        rst_n = 0; // 施加异步复位
        #10;       // 等待一段时间
        rst_n = 1; // 解除复位
        #10;

        // 测试数据输入
        d = 1;     // 设置数据输入为1
        #10;       // 等待时钟上升沿
        d = 0;     // 设置数据输入为0
        #10;       // 等待时钟上升沿
        d = 1;     // 设置数据输入为1
        #10;       // 等待时钟上升沿

        // 施加异步复位
        rst_n = 0; // 施加异步复位
        #10;       // 等待一段时间
        rst_n = 1; // 解除复位
        #10;

        // 结束仿真
        $finish;
    end

    // 监视输出
    initial begin
        $monitor("Time: %0t | rst_n: %b | d: %b | q: %b", $time, rst_n, d, q);
    end

endmodule
