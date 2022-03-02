`timescale 1ns / 1ps

module mux4x1_test;

	reg a0;
	reg a1;
	reg a2;
	reg a3;
	reg [1:0]s;
	wire M;

	MUX4x1 uut (
		.M(M),
		.x0(a0), 
		.x1(a1),
		.x2(a2),
		.x3(a3),
		.s(s)
	);

	initial begin
		$dumpfile("mux4x1_test.vcd");
    $dumpvars(0,mux4x1_test);
		a0 = 1'b0;
		a1 = 1'b0;
		a2 = 1'b0;
		a3 = 1'b0;
		s=0;

		#320 $finish;
  end

  always #80 s[0]=~s[0];
	always #160 s[1]=~s[1];
	always #5 a3=~a3;
	always #10 a2=~a2;
	always #20 a1=~a1;
	always #40 a0=~a0;

	initial
    $monitor("time=%0t s1=%d s0=%d a0=%d a1=%d a2=%d a3=%d y=%d",$time,s[1],s[0],a0,a1,a2,a3,M);
      
endmodule