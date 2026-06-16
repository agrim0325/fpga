-- Version: 2025.2 2025.2.0.14

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity apb_led_slave is

    port( PCLK    : in    std_logic;
          PRESETN : in    std_logic;
          PSEL    : in    std_logic;
          PENABLE : in    std_logic;
          PWRITE  : in    std_logic;
          PADDR   : in    std_logic_vector(7 downto 0);
          PWDATA  : in    std_logic_vector(31 downto 0);
          PRDATA  : out   std_logic_vector(31 downto 0);
          PREADY  : out   std_logic;
          led     : out   std_logic_vector(3 downto 0)
        );

end apb_led_slave;

architecture DEF_ARCH of apb_led_slave is 

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

  component OUTBUF
    generic (IOSTD:string := "");

    port( D   : in    std_logic := 'U';
          PAD : out   std_logic
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

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CLKINT
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

    signal PADDR_c : std_logic_vector(7 downto 0);
    signal PWDATA_c : std_logic_vector(3 downto 0);
    signal PRDATA_c : std_logic_vector(3 downto 0);
    signal led_c : std_logic_vector(3 downto 0);
    signal \GND\, \VCC\, led4_Z, led_0_sqmuxa_Z, PCLK_c, 
        PRESETN_c, PSEL_c, PENABLE_c, PWRITE_c, led4_3_Z, 
        led4_4_Z, PCLK_ibuf_Z : std_logic;

begin 


    \PWDATA_ibuf[1]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => PWDATA(1), Y => PWDATA_c(1));
    
    led_0_sqmuxa : CFG4
      generic map(INIT => x"8000")

      port map(A => led4_Z, B => PWRITE_c, C => PSEL_c, D => 
        PENABLE_c, Y => led_0_sqmuxa_Z);
    
    \PRDATA_1[3]\ : CFG4
      generic map(INIT => x"0800")

      port map(A => led_c(3), B => led4_Z, C => PWRITE_c, D => 
        PSEL_c, Y => PRDATA_c(3));
    
    \PADDR_ibuf[0]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => PADDR(0), Y => PADDR_c(0));
    
    \PRDATA_obuf[14]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(14));
    
    \led_Z[0]\ : SLE
      port map(D => PWDATA_c(0), CLK => PCLK_c, EN => 
        led_0_sqmuxa_Z, ALn => PRESETN_c, ADn => \VCC\, SLn => 
        \VCC\, SD => \GND\, LAT => \GND\, Q => led_c(0));
    
    \led_Z[3]\ : SLE
      port map(D => PWDATA_c(3), CLK => PCLK_c, EN => 
        led_0_sqmuxa_Z, ALn => PRESETN_c, ADn => \VCC\, SLn => 
        \VCC\, SD => \GND\, LAT => \GND\, Q => led_c(3));
    
    \PWDATA_ibuf[3]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => PWDATA(3), Y => PWDATA_c(3));
    
    \PRDATA_obuf[27]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(27));
    
    \PRDATA_obuf[18]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(18));
    
    \PRDATA_obuf[29]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(29));
    
    \PADDR_ibuf[1]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => PADDR(1), Y => PADDR_c(1));
    
    led4_3 : CFG2
      generic map(INIT => x"1")

      port map(A => PADDR_c(6), B => PADDR_c(7), Y => led4_3_Z);
    
    PRESETN_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => PRESETN, Y => PRESETN_c);
    
    \PRDATA_obuf[8]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(8));
    
    \led_obuf[2]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => led_c(2), PAD => led(2));
    
    \PADDR_ibuf[3]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => PADDR(3), Y => PADDR_c(3));
    
    \PWDATA_ibuf[0]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => PWDATA(0), Y => PWDATA_c(0));
    
    \PRDATA_obuf[20]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(20));
    
    \PRDATA_obuf[11]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(11));
    
    \PRDATA_obuf[22]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(22));
    
    \PRDATA_obuf[31]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(31));
    
    \PRDATA_obuf[26]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(26));
    
    \PRDATA_obuf[25]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(25));
    
    \PRDATA_obuf[1]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => PRDATA_c(1), PAD => PRDATA(1));
    
    led4 : CFG4
      generic map(INIT => x"0008")

      port map(A => led4_4_Z, B => led4_3_Z, C => PADDR_c(5), D
         => PADDR_c(4), Y => led4_Z);
    
    \PRDATA_obuf[17]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(17));
    
    \PRDATA_obuf[3]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => PRDATA_c(3), PAD => PRDATA(3));
    
    \PRDATA_obuf[19]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(19));
    
    PCLK_ibuf_RNIFTKQ4 : CLKINT
      port map(A => PCLK_ibuf_Z, Y => PCLK_c);
    
    \led_obuf[1]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => led_c(1), PAD => led(1));
    
    PENABLE_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => PENABLE, Y => PENABLE_c);
    
    \PRDATA_obuf[23]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(23));
    
    \led_obuf[3]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => led_c(3), PAD => led(3));
    
    \PRDATA_1[0]\ : CFG4
      generic map(INIT => x"0800")

      port map(A => led_c(0), B => led4_Z, C => PWRITE_c, D => 
        PSEL_c, Y => PRDATA_c(0));
    
    \PRDATA_obuf[10]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(10));
    
    \PRDATA_1[2]\ : CFG4
      generic map(INIT => x"0800")

      port map(A => led_c(2), B => led4_Z, C => PWRITE_c, D => 
        PSEL_c, Y => PRDATA_c(2));
    
    \PRDATA_obuf[12]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(12));
    
    \PRDATA_obuf[30]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(30));
    
    \PRDATA_obuf[16]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(16));
    
    \PRDATA_obuf[15]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(15));
    
    \PRDATA_obuf[0]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => PRDATA_c(0), PAD => PRDATA(0));
    
    \PRDATA_1[1]\ : CFG4
      generic map(INIT => x"0800")

      port map(A => led_c(1), B => led4_Z, C => PWRITE_c, D => 
        PSEL_c, Y => PRDATA_c(1));
    
    \PRDATA_obuf[6]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(6));
    
    \led_Z[1]\ : SLE
      port map(D => PWDATA_c(1), CLK => PCLK_c, EN => 
        led_0_sqmuxa_Z, ALn => PRESETN_c, ADn => \VCC\, SLn => 
        \VCC\, SD => \GND\, LAT => \GND\, Q => led_c(1));
    
    PWRITE_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => PWRITE, Y => PWRITE_c);
    
    \PRDATA_obuf[5]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(5));
    
    \PADDR_ibuf[7]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => PADDR(7), Y => PADDR_c(7));
    
    \led_Z[2]\ : SLE
      port map(D => PWDATA_c(2), CLK => PCLK_c, EN => 
        led_0_sqmuxa_Z, ALn => PRESETN_c, ADn => \VCC\, SLn => 
        \VCC\, SD => \GND\, LAT => \GND\, Q => led_c(2));
    
    \PWDATA_ibuf[2]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => PWDATA(2), Y => PWDATA_c(2));
    
    PREADY_obuf : OUTBUF
      generic map(IOSTD => "")

      port map(D => \VCC\, PAD => PREADY);
    
    \PRDATA_obuf[13]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(13));
    
    \PADDR_ibuf[6]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => PADDR(6), Y => PADDR_c(6));
    
    GND_Z : GND
      port map(Y => \GND\);
    
    VCC_Z : VCC
      port map(Y => \VCC\);
    
    \PADDR_ibuf[2]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => PADDR(2), Y => PADDR_c(2));
    
    \PRDATA_obuf[9]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(9));
    
    \PRDATA_obuf[4]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(4));
    
    \PADDR_ibuf[5]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => PADDR(5), Y => PADDR_c(5));
    
    PSEL_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => PSEL, Y => PSEL_c);
    
    \PADDR_ibuf[4]\ : INBUF
      generic map(IOSTD => "")

      port map(PAD => PADDR(4), Y => PADDR_c(4));
    
    \PRDATA_obuf[24]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(24));
    
    \PRDATA_obuf[28]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(28));
    
    PCLK_ibuf : INBUF
      generic map(IOSTD => "")

      port map(PAD => PCLK, Y => PCLK_ibuf_Z);
    
    \led_obuf[0]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => led_c(0), PAD => led(0));
    
    led4_4 : CFG4
      generic map(INIT => x"0001")

      port map(A => PADDR_c(3), B => PADDR_c(2), C => PADDR_c(1), 
        D => PADDR_c(0), Y => led4_4_Z);
    
    \PRDATA_obuf[7]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(7));
    
    \PRDATA_obuf[2]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => PRDATA_c(2), PAD => PRDATA(2));
    
    \PRDATA_obuf[21]\ : OUTBUF
      generic map(IOSTD => "")

      port map(D => \GND\, PAD => PRDATA(21));
    

end DEF_ARCH; 
