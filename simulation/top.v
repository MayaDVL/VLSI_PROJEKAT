module top;
    reg [2:0]oc_top;
    reg [3:0]a_top;
    reg [3:0]b_top; 
    wire [3:0]f_top;

    alu init1(.oc(oc_top), .a(a_top), .b(b_top), .f(f_top));

    integer i;
    
    reg clk;
    reg rst_n; 
    reg cl; 
    reg ld;
    reg [3:0]in; 
    reg inc; 
    reg dec; 
    reg sr; 
    reg ir; 
    reg sl; 
    reg il;
    wire [3:0]out;

    register init2(clk, rst_n, cl, ld, in, inc, dec, sr, ir, sl, il, out);

    initial begin
        rst_n = 1'b0;
        clk = 1'b0;
        forever begin
            #5 clk = ~clk;
        end
    end
    
    initial begin
        
        cl = 1'b0;
        ld = 1'b0;
        in = 4'b0000;
        inc = 1'b0;
        dec = 1'b0;
        sr = 1'b0;
        ir = 1'b0;
        sl = 1'b0;
        il = 1'b0;
        //#7;
        //rst_n = 1'b1;
        #1000;
        $stop;
    end

    initial begin
        //wait(rst_n == 1'b1);
        $monitor("Vreme = %2d, oc= %b, a=%b, b=%b, f=%b", $time, oc_top, a_top, b_top, f_top);
        for (i = 0; i < 2**11 ; i = i +1) begin
            {oc_top, a_top, b_top} = i;
            #10;
        end
        #10 $stop;
        /*
        cl = 1'b0;
        ld = 1'b0;
        in = 4'b0000;
        inc = 1'b0;
        dec = 1'b0;
        sr = 1'b0;
        ir = 1'b0;
        sl = 1'b0;
        il = 1'b0;
        */
        
        #7 rst_n = 1'b1;
        repeat(1000)begin
            #10;
            cl = $urandom%2;
            ld = $urandom%2;
            in = $urandom%16;
            inc = $urandom%2;
            dec = $urandom%2;
            sr = $urandom%2;
            ir = $urandom%2;
            sl = $urandom%2;
            il = $urandom%2;
        end
        #10 $finish;
    end

    always @(out) begin
        wait(rst_n == 1'b1);
        $display("Vreme = %2d, cl= %b, ld=%b, in=%b, inc=%b, dec=%b, sr=%b, ir=%b, sl=%b, il=%b, out=%b",
                     $time, cl, ld, in, inc, dec, sr, ir, sl, il, out);
    end
    

endmodule