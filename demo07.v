module demo07 (
    input wire clk,      // 时钟信号
    input wire rst_n,    // 异步复位信号（低有效）
    input wire d,       // 数据输入
    output reg q        // 数据输出
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 1'b0;   // 异步复位，输出清零
        end else begin
            q <= d;      // 在时钟上升沿时，输出等于输入
        end
    end

endmodule
