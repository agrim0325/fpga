-- Version: 2025.2 2025.2.0.14

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity traffic_light_fsm is

    port( clk   : in    std_logic;
          rst   : in    std_logic;
          roadA : out   std_logic_vector(1 downto 0);
          roadB : out   std_logic_vector(1 downto 0)
        );

end traffic_light_fsm;

architecture DEF_ARCH of traffic_light_fsm is 

  component GND
    port( Y : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component OUTBUF
    generic (IOSTD:string := "");

    port( D   : in    std_logic := 'U';
          PAD : out   std_logic
        );
  end component;

  component CFG1
    generic (INIT:std_logic_vector(1 downto 0) := "00");

    port( A : in    std_logic := 'U';
          Y : out   std_logic
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

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
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

    signal count_Z : std_logic_vector(2 downto 1);
    signal roadA_d : std_logic_vector(1 downto 0);
    signal roadB_d : std_logic_vector(1 to 1);
    signal state_Z : std_logic_vector(1 downto 0);
    signal state_ns : std_logic_vector(1 to 1);
    signal count_i : std_logic_vector(1 to 1);
    signal \VCC\, \GND\, N_7, N_8, N_9, N_10, CO0, clk_c, rst_c, 
        N_36_i, N_42_i, \state_ns_1_0__N_4_i\, N_46_i, N_44_i, 
        rst_c_i, clk_ibuf_Z : std_logic;

begin 


    GND_Z : GND
      port map(Y => \GND\);
    
    state_s0_0_a3 : CFG2
      generic map(INIT => x"1")

      port map(A => state_Z(0), B => state_Z(1), Y => roadA_d(1));
    
    \roadB_obuf[0]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => N_36_i, PAD => roadB(0));
    
    \count_RNIIBQH6[1]\ : CFG1
      generic map(INIT => "01")

      port map(A => count_Z(1), Y => count_i(1));
    
    clk_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => clk, Y => clk_ibuf_Z);
    
    VCC_Z : VCC
      port map(Y => \VCC\);
    
    \state[1]\ : SLE
      port map(D => state_ns(1), CLK => clk_c, EN => count_i(1), 
        ALn => rst_c_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, 
        LAT => \GND\, Q => state_Z(1));
    
    \count_RNO[1]\ : CFG4
      generic map(INIT => x"5A52")

      port map(A => CO0, B => state_Z(0), C => count_Z(1), D => 
        count_Z(2), Y => N_44_i);
    
    \roadB_obuf_RNO[0]\ : CFG2
      generic map(INIT => x"8")

      port map(A => state_Z(0), B => state_Z(1), Y => N_36_i);
    
    \roadB_obuf[1]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => roadB_d(1), PAD => roadB(1));
    
    \roadA_obuf[0]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => roadA_d(0), PAD => roadA(0));
    
    \count[0]\ : SLE
      port map(D => N_42_i, CLK => clk_c, EN => \VCC\, ALn => 
        rst_c_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT => 
        \GND\, Q => CO0);
    
    \state_ns_1_0_.N_4_i\ : CFG3
      generic map(INIT => x"D4")

      port map(A => CO0, B => state_Z(0), C => count_Z(2), Y => 
        \state_ns_1_0__N_4_i\);
    
    rst_ibuf_RNIUUM54 : CFG1
      generic map(INIT => "01")

      port map(A => rst_c, Y => rst_c_i);
    
    \roadA_obuf[1]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => roadA_d(1), PAD => roadA(1));
    
    state_s2_0_a3 : CFG2
      generic map(INIT => x"4")

      port map(A => state_Z(0), B => state_Z(1), Y => roadB_d(1));
    
    clk_ibuf_RNIVTI21 : CLKINT
      port map(A => clk_ibuf_Z, Y => clk_c);
    
    rst_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => rst, Y => rst_c);
    
    \count_RNO[2]\ : CFG4
      generic map(INIT => x"5EA0")

      port map(A => CO0, B => state_Z(0), C => count_Z(1), D => 
        count_Z(2), Y => N_46_i);
    
    state_s1_0_a3 : CFG2
      generic map(INIT => x"2")

      port map(A => state_Z(0), B => state_Z(1), Y => roadA_d(0));
    
    \count[1]\ : SLE
      port map(D => N_44_i, CLK => clk_c, EN => \VCC\, ALn => 
        rst_c_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT => 
        \GND\, Q => count_Z(1));
    
    \count_RNO[0]\ : CFG4
      generic map(INIT => x"5455")

      port map(A => CO0, B => state_Z(0), C => count_Z(1), D => 
        count_Z(2), Y => N_42_i);
    
    \state[0]\ : SLE
      port map(D => \state_ns_1_0__N_4_i\, CLK => clk_c, EN => 
        count_i(1), ALn => rst_c_i, ADn => \VCC\, SLn => \VCC\, 
        SD => \GND\, LAT => \GND\, Q => state_Z(0));
    
    \state_ns_1_0_.m5\ : CFG4
      generic map(INIT => x"9CCC")

      port map(A => count_Z(2), B => state_Z(1), C => state_Z(0), 
        D => CO0, Y => state_ns(1));
    
    \count[2]\ : SLE
      port map(D => N_46_i, CLK => clk_c, EN => \VCC\, ALn => 
        rst_c_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT => 
        \GND\, Q => count_Z(2));
    

end DEF_ARCH; 
