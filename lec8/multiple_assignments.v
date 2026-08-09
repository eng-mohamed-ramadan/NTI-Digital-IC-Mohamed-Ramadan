module multiple_assignments;

  reg [3:0] a, b, c;

  reg [4:0] p_blk, q_blk;
  reg [3:0] m_blk, n_blk;

  reg [4:0] p_nblk, q_nblk;
  reg [3:0] m_nblk, n_nblk;

  always @(a, b, c) begin
    m_blk = a;
    n_blk = b;
    p_blk = m_blk + n_blk;

    m_blk = c;
    q_blk = m_blk + n_blk;
  end

  always @(a, b, c, m_nblk, n_nblk) begin
    m_nblk <= a;
    n_nblk <= b;
    p_nblk <= m_nblk + n_nblk;

    m_nblk <= c;
    q_nblk <= m_nblk + n_nblk;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, multiple_assignments);

    $display("Time | Inputs (a,b,c) | BLOCKING (Intended) | NON-BLOCKING (Broken)");
    $display("----------------------------------------------------------------------");

    $monitor("%4t | a=%0d, b=%0d, c=%0d | p_blk=%0d, q_blk=%0d | p_nblk=%0d, q_nblk=%0d",
             $time, a, b, c, p_blk, q_blk, p_nblk, q_nblk);

    #10 a = 2; b = 3; c = 10;
    #10 a = 5; b = 5; c = 20;

    #30 $stop;
  end
endmodule