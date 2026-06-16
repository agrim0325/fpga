-- Version: 2025.2 2025.2.0.14

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity shift_register is

    port( clk         : in    std_logic;
          rst         : in    std_logic;
          en          : in    std_logic;
          sel         : in    std_logic_vector(1 downto 0);
          serial_in   : in    std_logic;
          parallel_in : in    std_logic_vector(3 downto 0);
          q           : out   std_logic_vector(3 downto 0)
        );

end shift_register;

architecture DEF_ARCH of shift_register is 

  component INBUF
    generic (IOSTD:string := "");

    port( PAD : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
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

  component CLKINT
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

    signal q_6_Z : std_logic_vector(3 downto 0);
    signal parallel_in_c : std_logic_vector(3 downto 0);
    signal q_c : std_logic_vector(3 downto 0);
    signal q_6_1_Z : std_logic_vector(3 downto 0);
    signal \GND\, \VCC\, clk_c, rst_c, en_c, NN_1, NN_2, 
        serial_in_c, un1_q16_i, rst_c_i, clk_ibuf_Z : std_logic;

begin 


    \sel_ibuf[0]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => sel(0), Y => NN_1);
    
    \q_6_1[3]\ : CFG4
      generic map(INIT => x"3A0A")

      port map(A => serial_in_c, B => NN_2, C => NN_1, D => 
        q_c(2), Y => q_6_1_Z(3));
    
    \parallel_in_ibuf[3]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => parallel_in(3), Y => parallel_in_c(3));
    
    GND_Z : GND
      port map(Y => \GND\);
    
    \q_6_1[1]\ : CFG4
      generic map(INIT => x"7430")

      port map(A => NN_2, B => NN_1, C => q_c(2), D => q_c(0), Y
         => q_6_1_Z(1));
    
    \q_6[1]\ : CFG4
      generic map(INIT => x"F8F0")

      port map(A => NN_1, B => NN_2, C => q_6_1_Z(1), D => 
        parallel_in_c(1), Y => q_6_Z(1));
    
    \sel_ibuf[1]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => sel(1), Y => NN_2);
    
    en_ibuf_RNIREHDJ : CFG3
      generic map(INIT => x"E0")

      port map(A => NN_2, B => NN_1, C => en_c, Y => un1_q16_i);
    
    \q_Z[2]\ : SLE
      port map(D => q_6_Z(2), CLK => clk_c, EN => un1_q16_i, ALn
         => rst_c_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => q_c(2));
    
    clk_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => clk, Y => clk_ibuf_Z);
    
    VCC_Z : VCC
      port map(Y => \VCC\);
    
    \q_6_1[2]\ : CFG4
      generic map(INIT => x"7430")

      port map(A => NN_2, B => NN_1, C => q_c(3), D => q_c(1), Y
         => q_6_1_Z(2));
    
    rst_ibuf_RNIUUM54 : CFG1
      generic map(INIT => "01")

      port map(A => rst_c, Y => rst_c_i);
    
    \q_Z[0]\ : SLE
      port map(D => q_6_Z(0), CLK => clk_c, EN => un1_q16_i, ALn
         => rst_c_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => q_c(0));
    
    \q_6[0]\ : CFG4
      generic map(INIT => x"F8F0")

      port map(A => NN_1, B => NN_2, C => q_6_1_Z(0), D => 
        parallel_in_c(0), Y => q_6_Z(0));
    
    serial_in_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => serial_in, Y => serial_in_c);
    
    \q_Z[1]\ : SLE
      port map(D => q_6_Z(1), CLK => clk_c, EN => un1_q16_i, ALn
         => rst_c_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => q_c(1));
    
    \q_obuf[3]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => q_c(3), PAD => q(3));
    
    \q_obuf[1]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => q_c(1), PAD => q(1));
    
    \q_obuf[2]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => q_c(2), PAD => q(2));
    
    \q_6[2]\ : CFG4
      generic map(INIT => x"F8F0")

      port map(A => NN_1, B => NN_2, C => q_6_1_Z(2), D => 
        parallel_in_c(2), Y => q_6_Z(2));
    
    clk_ibuf_RNIVTI21 : CLKINT
      port map(A => clk_ibuf_Z, Y => clk_c);
    
    \parallel_in_ibuf[0]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => parallel_in(0), Y => parallel_in_c(0));
    
    \parallel_in_ibuf[1]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => parallel_in(1), Y => parallel_in_c(1));
    
    rst_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => rst, Y => rst_c);
    
    \parallel_in_ibuf[2]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => parallel_in(2), Y => parallel_in_c(2));
    
    \q_Z[3]\ : SLE
      port map(D => q_6_Z(3), CLK => clk_c, EN => un1_q16_i, ALn
         => rst_c_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => q_c(3));
    
    \q_obuf[0]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => q_c(0), PAD => q(0));
    
    en_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => en, Y => en_c);
    
    \q_6_1[0]\ : CFG4
      generic map(INIT => x"2F20")

      port map(A => serial_in_c, B => NN_2, C => NN_1, D => 
        q_c(1), Y => q_6_1_Z(0));
    
    \q_6[3]\ : CFG4
      generic map(INIT => x"F8F0")

      port map(A => NN_1, B => NN_2, C => q_6_1_Z(3), D => 
        parallel_in_c(3), Y => q_6_Z(3));
    

end DEF_ARCH; 
