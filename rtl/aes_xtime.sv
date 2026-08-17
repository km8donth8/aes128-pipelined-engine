`timescale 1ns/1ps

module aes_xtime (
    input  logic [7:0] data_i,
    output logic [7:0] data_o
);

    // Multiplication by 2 in the AES GF(2^8) finite field.
    assign data_o =
        {data_i[6:0], 1'b0}
        ^ (8'h1b & {8{data_i[7]}});

endmodule