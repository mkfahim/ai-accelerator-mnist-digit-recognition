module maxFinder #(parameter numInput=10,parameter inputWidth=16)(
input       wire    clk,
input       wire    rst,
input wire [(numInput*inputWidth)-1:0]   i_data,
input     wire       i_valid,
output wire [15:0]o_data,
output  wire     o_data_valid
);
reg o_data_valid1;
reg [15:0] o_data1;
reg [inputWidth-1:0] maxValue;
reg [(numInput*inputWidth)-1:0] inDataBuffer;
integer counter;
assign o_data_valid=o_data_valid1;
assign o_data=o_data1;

always @(posedge clk)
begin
    //o_data_valid1 <= 1'b0;
    if(rst)
    begin
       o_data_valid1 <= 1'b0;
    end
    else 
    if(i_valid)
    begin
        o_data_valid1 <= 1'b0;
        maxValue <= i_data[inputWidth-1:0];
        counter <= 1;
        inDataBuffer <= i_data;
        o_data1 <= 0;
    end
    else if(counter == numInput)
    begin
        counter <= 0;
        o_data_valid1 <= 1'b1;
    end
    else if(counter != 0)
    begin
        counter <= counter + 1;
        if(inDataBuffer[counter*inputWidth+:inputWidth] > maxValue)
        begin
            maxValue <= inDataBuffer[counter*inputWidth+:inputWidth];
            o_data1 <= counter;
        end
    end
    else
    begin
    o_data_valid1 <= 1'b0;  // Explicitly drive o_data_valid1 low when no valid output is present
    end
    end


endmodule