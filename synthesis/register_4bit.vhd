-- Version: 2025.2 2025.2.0.14

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity register_4bit is

    port( clk : in    std_logic;
          rst : in    std_logic;
          en  : in    std_logic;
          d   : in    std_logic_vector(3 downto 0);
          q   : out   std_logic_vector(3 downto 0)
        );

end register_4bit;

architecture DEF_ARCH of register_4bit is 

  component GND
    port( Y : out   std_logic
        );
  end component;

  component INBUF
    generic (IOSTD:string := "");

    port( PAD : in    std_logic := 'U';
          Y   : out   std_logic
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

    signal d_c : std_logic_vector(3 downto 0);
    signal q_c : std_logic_vector(3 downto 0);
    signal \GND\, \VCC\, clk_c, rst_c, en_c, rst_c_i, clk_ibuf_Z
         : std_logic;

begin 


    GND_Z : GND
      port map(Y => \GND\);
    
    \d_ibuf[3]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => d(3), Y => d_c(3));
    
    \d_ibuf[1]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => d(1), Y => d_c(1));
    
    \d_ibuf[2]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => d(2), Y => d_c(2));
    
    \q_Z[2]\ : SLE
      port map(D => d_c(2), CLK => clk_c, EN => en_c, ALn => 
        rst_c_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT => 
        \GND\, Q => q_c(2));
    
    clk_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => clk, Y => clk_ibuf_Z);
    
    VCC_Z : VCC
      port map(Y => \VCC\);
    
    rst_ibuf_RNIUUM54 : CFG1
      generic map(INIT => "01")

      port map(A => rst_c, Y => rst_c_i);
    
    \q_Z[0]\ : SLE
      port map(D => d_c(0), CLK => clk_c, EN => en_c, ALn => 
        rst_c_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT => 
        \GND\, Q => q_c(0));
    
    \d_ibuf[0]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => d(0), Y => d_c(0));
    
    \q_Z[1]\ : SLE
      port map(D => d_c(1), CLK => clk_c, EN => en_c, ALn => 
        rst_c_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT => 
        \GND\, Q => q_c(1));
    
    \q_obuf[3]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => q_c(3), PAD => q(3));
    
    \q_obuf[1]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => q_c(1), PAD => q(1));
    
    \q_obuf[2]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => q_c(2), PAD => q(2));
    
    clk_ibuf_RNIVTI21 : CLKINT
      port map(A => clk_ibuf_Z, Y => clk_c);
    
    rst_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => rst, Y => rst_c);
    
    \q_Z[3]\ : SLE
      port map(D => d_c(3), CLK => clk_c, EN => en_c, ALn => 
        rst_c_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT => 
        \GND\, Q => q_c(3));
    
    \q_obuf[0]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => q_c(0), PAD => q(0));
    
    en_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => en, Y => en_c);
    

end DEF_ARCH; 
