-- Version: 2025.2 2025.2.0.14

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity flipflops is

    port( clk  : in    std_logic;
          rst  : in    std_logic;
          d    : in    std_logic;
          j    : in    std_logic;
          k    : in    std_logic;
          t    : in    std_logic;
          q_d  : out   std_logic;
          q_jk : out   std_logic;
          q_t  : out   std_logic;
          q_sr : out   std_logic;
          s    : in    std_logic;
          r    : in    std_logic
        );

end flipflops;

architecture DEF_ARCH of flipflops is 

  component GND
    port( Y : out   std_logic
        );
  end component;

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component INBUF
    generic (IOSTD:string := "");

    port( PAD : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component CFG1
    generic (INIT:std_logic_vector(1 downto 0) := "00");

    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component OUTBUF
    generic (IOSTD:string := "");

    port( D   : in    std_logic := 'U';
          PAD : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CLKINT
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

    signal \VCC\, \GND\, q_jk_reg_3, q_t_reg_0_Z, clk_c, rst_c, 
        d_c, NN_1, NN_2, t_c, s_c, r_c, q_d_c, q_jk_c, q_t_c, 
        q_sr_c, r_c_i, q_sr_reg3_i_Z, q_jk_reg3_i_Z, rst_c_i, 
        clk_ibuf_Z : std_logic;

begin 


    GND_Z : GND
      port map(Y => \GND\);
    
    q_sr_reg : SLE
      port map(D => r_c_i, CLK => clk_c, EN => q_sr_reg3_i_Z, ALn
         => rst_c_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => q_sr_c);
    
    clk_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => clk, Y => clk_ibuf_Z);
    
    VCC_Z : VCC
      port map(Y => \VCC\);
    
    q_t_reg : SLE
      port map(D => q_t_reg_0_Z, CLK => clk_c, EN => \VCC\, ALn
         => rst_c_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => q_t_c);
    
    r_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => r, Y => r_c);
    
    rst_ibuf_RNIUUM54 : CFG1
      generic map(INIT => "01")

      port map(A => rst_c, Y => rst_c_i);
    
    t_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => t, Y => t_c);
    
    d_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => d, Y => d_c);
    
    s_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => s, Y => s_c);
    
    q_sr_obuf : OUTBUF
      generic map(IOSTD => "")

      port map(D => q_sr_c, PAD => q_sr);
    
    q_jk_reg_3_f0 : CFG3
      generic map(INIT => x"2A")

      port map(A => NN_1, B => q_jk_c, C => NN_2, Y => q_jk_reg_3);
    
    clk_ibuf_RNIVTI21 : CLKINT
      port map(A => clk_ibuf_Z, Y => clk_c);
    
    q_sr_reg_RNO : CFG1
      generic map(INIT => "01")

      port map(A => r_c, Y => r_c_i);
    
    q_jk_reg : SLE
      port map(D => q_jk_reg_3, CLK => clk_c, EN => q_jk_reg3_i_Z, 
        ALn => rst_c_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, 
        LAT => \GND\, Q => q_jk_c);
    
    q_d_obuf : OUTBUF
      generic map(IOSTD => "")

      port map(D => q_d_c, PAD => q_d);
    
    rst_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => rst, Y => rst_c);
    
    q_t_reg_0 : CFG2
      generic map(INIT => x"6")

      port map(A => q_t_c, B => t_c, Y => q_t_reg_0_Z);
    
    q_jk_reg3_i : CFG2
      generic map(INIT => x"E")

      port map(A => NN_1, B => NN_2, Y => q_jk_reg3_i_Z);
    
    k_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => k, Y => NN_2);
    
    q_jk_obuf : OUTBUF
      generic map(IOSTD => "")

      port map(D => q_jk_c, PAD => q_jk);
    
    q_t_obuf : OUTBUF
      generic map(IOSTD => "")

      port map(D => q_t_c, PAD => q_t);
    
    q_d_reg : SLE
      port map(D => d_c, CLK => clk_c, EN => \VCC\, ALn => 
        rst_c_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT => 
        \GND\, Q => q_d_c);
    
    q_sr_reg3_i : CFG2
      generic map(INIT => x"E")

      port map(A => r_c, B => s_c, Y => q_sr_reg3_i_Z);
    
    j_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => j, Y => NN_1);
    

end DEF_ARCH; 
