-- Version: 2025.2 2025.2.0.14
-- File used only for Simulation

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity sdf_IOPAD_TRI is

    port( PAD : out   std_logic;
          D   : in    std_logic;
          E   : in    std_logic
        );

end sdf_IOPAD_TRI;

architecture DEF_ARCH of sdf_IOPAD_TRI is 

  component IOPAD_TRI_VDDI
    port( OIN_VDD : in    std_logic := 'U';
          EIN_VDD : in    std_logic := 'U';
          PAD_P   : out   std_logic
        );
  end component;

  component IOPAD_VDD
    port( OIN_P    : in    std_logic := 'U';
          EIN_P    : in    std_logic := 'U';
          IOUT_VDD : in    std_logic := 'U';
          OIN_VDD  : out   std_logic;
          EIN_VDD  : out   std_logic;
          IOUT_IN  : out   std_logic
        );
  end component;

    signal NET_OIN_VDD, NET_EIN_VDD : std_logic;

begin 


    U_VCCI : IOPAD_TRI_VDDI
      port map(OIN_VDD => NET_OIN_VDD, EIN_VDD => NET_EIN_VDD, 
        PAD_P => PAD);
    
    U_VCCA : IOPAD_VDD
      port map(OIN_P => D, EIN_P => E, IOUT_VDD => OPEN, OIN_VDD
         => NET_OIN_VDD, EIN_VDD => NET_EIN_VDD, IOUT_IN => OPEN);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity sdf_IOPAD_IN is

    port( PAD : in    std_logic;
          Y   : out   std_logic
        );

end sdf_IOPAD_IN;

architecture DEF_ARCH of sdf_IOPAD_IN is 

  component IOPAD_IN_VDDI
    port( PAD_P    : in    std_logic := 'U';
          IOUT_VDD : out   std_logic
        );
  end component;

  component IOPAD_DELAY
    port( IOUT_IN : in    std_logic := 'U';
          IOUT_P  : out   std_logic
        );
  end component;

  component IOPAD_VDD
    port( OIN_P    : in    std_logic := 'U';
          EIN_P    : in    std_logic := 'U';
          IOUT_VDD : in    std_logic := 'U';
          OIN_VDD  : out   std_logic;
          EIN_VDD  : out   std_logic;
          IOUT_IN  : out   std_logic
        );
  end component;

  component GND
    port(Y : out std_logic); 
  end component;

    signal NET_IOUT_VDD, NET_IOUT_IN, ADLIB_GND : std_logic;
    signal GND_power_net1 : std_logic;

begin 

    ADLIB_GND <= GND_power_net1;

    U_VCCI : IOPAD_IN_VDDI
      port map(PAD_P => PAD, IOUT_VDD => NET_IOUT_VDD);
    
    U_DELAY : IOPAD_DELAY
      port map(IOUT_IN => NET_IOUT_IN, IOUT_P => Y);
    
    U_VCCA : IOPAD_VDD
      port map(OIN_P => ADLIB_GND, EIN_P => ADLIB_GND, IOUT_VDD
         => NET_IOUT_VDD, OIN_VDD => OPEN, EIN_VDD => OPEN, 
        IOUT_IN => NET_IOUT_IN);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);


end DEF_ARCH; 

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

  component IOENFF_BYPASS
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component sdf_IOPAD_TRI
    port( PAD : out   std_logic;
          D   : in    std_logic := 'U';
          E   : in    std_logic := 'U'
        );
  end component;

  component IOOUTFF_BYPASS
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component sdf_IOPAD_IN
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

  component IOINFF_BYPASS
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component RGB_NG
    port( An  : in    std_logic := 'U';
          ENn : in    std_logic := 'U';
          YL  : out   std_logic;
          YR  : out   std_logic
        );
  end component;

  component INV_BA
    port( A : in    std_logic := 'U';
          Y : out   std_logic
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

  component GB_NG
    port( An  : in    std_logic := 'U';
          ENn : in    std_logic := 'U';
          YNn : out   std_logic;
          YSn : out   std_logic
        );
  end component;

  component IP_INTERFACE
    port( A   : in    std_logic := 'U';
          B   : in    std_logic := 'U';
          C   : in    std_logic := 'U';
          IPA : out   std_logic;
          IPB : out   std_logic;
          IPC : out   std_logic
        );
  end component;

  component FLASH_FREEZE
    port( FF_TO_START : out   std_logic;
          FF_DONE     : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component GND
    port(Y : out std_logic); 
  end component;

  component VCC
    port(Y : out std_logic); 
  end component;

    signal \PADDR_c[7]\, \PADDR_c[6]\, \PADDR_c[5]\, \PADDR_c[4]\, 
        \PADDR_c[3]\, \PADDR_c[2]\, \PADDR_c[1]\, \PADDR_c[0]\, 
        \PWDATA_c[3]\, \PWDATA_c[2]\, \PWDATA_c[1]\, 
        \PWDATA_c[0]\, \PRDATA_c[3]\, \PRDATA_c[2]\, 
        \PRDATA_c[1]\, \PRDATA_c[0]\, \led_c[3]\, \led_c[2]\, 
        \led_c[1]\, \led_c[0]\, \GND\, \VCC\, led4_Z, 
        led_0_sqmuxa_Z, \PCLK_ibuf_RNIFTKQ4/U0_YNn\, PRESETN_c, 
        PSEL_c, PENABLE_c, PWRITE_c, led4_3_Z, led4_4_Z, 
        ff_to_start_net, \PWDATA_ibuf[1]/U0/YIN1\, 
        \PADDR_ibuf[0]/U0/YIN1\, \PRDATA_obuf[14]/U0/DOUT\, 
        \PRDATA_obuf[14]/U0/EOUT\, \PWDATA_ibuf[3]/U0/YIN1\, 
        \PRDATA_obuf[27]/U0/DOUT\, \PRDATA_obuf[27]/U0/EOUT\, 
        \PRDATA_obuf[18]/U0/DOUT\, \PRDATA_obuf[18]/U0/EOUT\, 
        \PRDATA_obuf[29]/U0/DOUT\, \PRDATA_obuf[29]/U0/EOUT\, 
        \PADDR_ibuf[1]/U0/YIN1\, \PRESETN_ibuf/U0/YIN1\, 
        \PRDATA_obuf[8]/U0/DOUT\, \PRDATA_obuf[8]/U0/EOUT\, 
        \led_obuf[2]/U0/DOUT\, \led_obuf[2]/U0/EOUT\, 
        \PADDR_ibuf[3]/U0/YIN1\, \PWDATA_ibuf[0]/U0/YIN1\, 
        \PRDATA_obuf[20]/U0/DOUT\, \PRDATA_obuf[20]/U0/EOUT\, 
        \PRDATA_obuf[11]/U0/DOUT\, \PRDATA_obuf[11]/U0/EOUT\, 
        \PRDATA_obuf[22]/U0/DOUT\, \PRDATA_obuf[22]/U0/EOUT\, 
        \PRDATA_obuf[31]/U0/DOUT\, \PRDATA_obuf[31]/U0/EOUT\, 
        \PRDATA_obuf[26]/U0/DOUT\, \PRDATA_obuf[26]/U0/EOUT\, 
        \PRDATA_obuf[25]/U0/DOUT\, \PRDATA_obuf[25]/U0/EOUT\, 
        \PRDATA_obuf[1]/U0/DOUT\, \PRDATA_obuf[1]/U0/EOUT\, 
        \PRDATA_obuf[17]/U0/DOUT\, \PRDATA_obuf[17]/U0/EOUT\, 
        \PRDATA_obuf[3]/U0/DOUT\, \PRDATA_obuf[3]/U0/EOUT\, 
        \PRDATA_obuf[19]/U0/DOUT\, \PRDATA_obuf[19]/U0/EOUT\, 
        \led_obuf[1]/U0/DOUT\, \led_obuf[1]/U0/EOUT\, 
        \PENABLE_ibuf/U0/YIN1\, \PRDATA_obuf[23]/U0/DOUT\, 
        \PRDATA_obuf[23]/U0/EOUT\, \led_obuf[3]/U0/DOUT\, 
        \led_obuf[3]/U0/EOUT\, \PRDATA_obuf[10]/U0/DOUT\, 
        \PRDATA_obuf[10]/U0/EOUT\, \PRDATA_obuf[12]/U0/DOUT\, 
        \PRDATA_obuf[12]/U0/EOUT\, \PRDATA_obuf[30]/U0/DOUT\, 
        \PRDATA_obuf[30]/U0/EOUT\, \PRDATA_obuf[16]/U0/DOUT\, 
        \PRDATA_obuf[16]/U0/EOUT\, \PRDATA_obuf[15]/U0/DOUT\, 
        \PRDATA_obuf[15]/U0/EOUT\, \PRDATA_obuf[0]/U0/DOUT\, 
        \PRDATA_obuf[0]/U0/EOUT\, \PRDATA_obuf[6]/U0/DOUT\, 
        \PRDATA_obuf[6]/U0/EOUT\, \PWRITE_ibuf/U0/YIN1\, 
        \PRDATA_obuf[5]/U0/DOUT\, \PRDATA_obuf[5]/U0/EOUT\, 
        \PADDR_ibuf[7]/U0/YIN1\, \PWDATA_ibuf[2]/U0/YIN1\, 
        \PREADY_obuf/U0/DOUT\, \PREADY_obuf/U0/EOUT\, 
        \PRDATA_obuf[13]/U0/DOUT\, \PRDATA_obuf[13]/U0/EOUT\, 
        \PADDR_ibuf[6]/U0/YIN1\, \PADDR_ibuf[2]/U0/YIN1\, 
        \PRDATA_obuf[9]/U0/DOUT\, \PRDATA_obuf[9]/U0/EOUT\, 
        \PRDATA_obuf[4]/U0/DOUT\, \PRDATA_obuf[4]/U0/EOUT\, 
        \PADDR_ibuf[5]/U0/YIN1\, \PSEL_ibuf/U0/YIN1\, 
        \PADDR_ibuf[4]/U0/YIN1\, \PRDATA_obuf[24]/U0/DOUT\, 
        \PRDATA_obuf[24]/U0/EOUT\, \PRDATA_obuf[28]/U0/DOUT\, 
        \PRDATA_obuf[28]/U0/EOUT\, PCLK_ibuf_Z, 
        \PCLK_ibuf/U0/YIN\, \led_obuf[0]/U0/DOUT\, 
        \led_obuf[0]/U0/EOUT\, \PRDATA_obuf[7]/U0/DOUT\, 
        \PRDATA_obuf[7]/U0/EOUT\, \PRDATA_obuf[2]/U0/DOUT\, 
        \PRDATA_obuf[2]/U0/EOUT\, \PRDATA_obuf[21]/U0/DOUT\, 
        \PRDATA_obuf[21]/U0/EOUT\, PCLK_c, AFLSDF_VCC, AFLSDF_GND, 
        \AFLSDF_INV_0\ : std_logic;
    signal GND_power_net1 : std_logic;
    signal VCC_power_net1 : std_logic;

    for all : sdf_IOPAD_TRI
	Use entity work.sdf_IOPAD_TRI(DEF_ARCH);
    for all : sdf_IOPAD_IN
	Use entity work.sdf_IOPAD_IN(DEF_ARCH);
begin 

    AFLSDF_GND <= GND_power_net1;
    \GND\ <= GND_power_net1;
    \VCC\ <= VCC_power_net1;
    AFLSDF_VCC <= VCC_power_net1;

    \PRDATA_obuf[26]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[26]/U0/EOUT\);
    
    \PRDATA_obuf[6]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(6), D => \PRDATA_obuf[6]/U0/DOUT\, E
         => \PRDATA_obuf[6]/U0/EOUT\);
    
    \PRDATA_obuf[5]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[5]/U0/DOUT\);
    
    \PADDR_ibuf[6]/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => PADDR(6), Y => \PADDR_ibuf[6]/U0/YIN1\);
    
    \PADDR_ibuf[5]/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => PADDR(5), Y => \PADDR_ibuf[5]/U0/YIN1\);
    
    \led_Z[3]\ : SLE
      port map(D => \PWDATA_c[3]\, CLK => PCLK_c, EN => 
        led_0_sqmuxa_Z, ALn => PRESETN_c, ADn => \VCC\, SLn => 
        \VCC\, SD => \GND\, LAT => \GND\, Q => \led_c[3]\);
    
    \PADDR_ibuf[7]/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => PADDR(7), Y => \PADDR_ibuf[7]/U0/YIN1\);
    
    \PENABLE_ibuf/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \PENABLE_ibuf/U0/YIN1\, Y => PENABLE_c);
    
    \PADDR_ibuf[3]/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \PADDR_ibuf[3]/U0/YIN1\, Y => \PADDR_c[3]\);
    
    \PRDATA_obuf[22]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[22]/U0/EOUT\);
    
    \PCLK_ibuf/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => PCLK, Y => PCLK_ibuf_Z);
    
    \PRDATA_obuf[27]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[27]/U0/EOUT\);
    
    \led_obuf[3]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => led(3), D => \led_obuf[3]/U0/DOUT\, E => 
        \led_obuf[3]/U0/EOUT\);
    
    \led_obuf[3]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \led_c[3]\, Y => \led_obuf[3]/U0/DOUT\);
    
    \PRDATA_obuf[24]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[24]/U0/EOUT\);
    
    \PADDR_ibuf[0]/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \PADDR_ibuf[0]/U0/YIN1\, Y => \PADDR_c[0]\);
    
    \PADDR_ibuf[5]/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \PADDR_ibuf[5]/U0/YIN1\, Y => \PADDR_c[5]\);
    
    \PRDATA_obuf[0]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[0]/U0/EOUT\);
    
    \PRDATA_obuf[9]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(9), D => \PRDATA_obuf[9]/U0/DOUT\, E
         => \PRDATA_obuf[9]/U0/EOUT\);
    
    \PRDATA_obuf[29]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(29), D => \PRDATA_obuf[29]/U0/DOUT\, 
        E => \PRDATA_obuf[29]/U0/EOUT\);
    
    \PRDATA_obuf[11]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[11]/U0/DOUT\);
    
    \PADDR_ibuf[3]/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => PADDR(3), Y => \PADDR_ibuf[3]/U0/YIN1\);
    
    \led_obuf[1]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => led(1), D => \led_obuf[1]/U0/DOUT\, E => 
        \led_obuf[1]/U0/EOUT\);
    
    \PRDATA_obuf[1]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \PRDATA_c[1]\, Y => \PRDATA_obuf[1]/U0/DOUT\);
    
    \PRDATA_obuf[2]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \PRDATA_c[2]\, Y => \PRDATA_obuf[2]/U0/DOUT\);
    
    \PRDATA_obuf[21]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(21), D => \PRDATA_obuf[21]/U0/DOUT\, 
        E => \PRDATA_obuf[21]/U0/EOUT\);
    
    \PRDATA_obuf[16]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(16), D => \PRDATA_obuf[16]/U0/DOUT\, 
        E => \PRDATA_obuf[16]/U0/EOUT\);
    
    \PWDATA_ibuf[2]/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \PWDATA_ibuf[2]/U0/YIN1\, Y => \PWDATA_c[2]\);
    
    \PADDR_ibuf[2]/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \PADDR_ibuf[2]/U0/YIN1\, Y => \PADDR_c[2]\);
    
    \PRDATA_obuf[24]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[24]/U0/DOUT\);
    
    \led_Z[1]\ : SLE
      port map(D => \PWDATA_c[1]\, CLK => PCLK_c, EN => 
        led_0_sqmuxa_Z, ALn => PRESETN_c, ADn => \VCC\, SLn => 
        \VCC\, SD => \GND\, LAT => \GND\, Q => \led_c[1]\);
    
    \PRDATA_obuf[25]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[25]/U0/DOUT\);
    
    \PCLK_ibuf_RNIFTKQ4/U0_RGB1\ : RGB_NG
      port map(An => \PCLK_ibuf_RNIFTKQ4/U0_YNn\, ENn => \GND\, 
        YL => PCLK_c, YR => OPEN);
    
    \PRDATA_obuf[31]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[31]/U0/EOUT\);
    
    \led_obuf[1]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \led_obuf[1]/U0/EOUT\);
    
    \PRDATA_obuf[13]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(13), D => \PRDATA_obuf[13]/U0/DOUT\, 
        E => \PRDATA_obuf[13]/U0/EOUT\);
    
    AFLSDF_INV_0 : INV_BA
      port map(A => PCLK_ibuf_Z, Y => \AFLSDF_INV_0\);
    
    \PRDATA_1[0]\ : CFG4
      generic map(INIT => x"0800")

      port map(A => \led_c[0]\, B => led4_Z, C => PWRITE_c, D => 
        PSEL_c, Y => \PRDATA_c[0]\);
    
    \PWRITE_ibuf/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \PWRITE_ibuf/U0/YIN1\, Y => PWRITE_c);
    
    \PRDATA_1[2]\ : CFG4
      generic map(INIT => x"0800")

      port map(A => \led_c[2]\, B => led4_Z, C => PWRITE_c, D => 
        PSEL_c, Y => \PRDATA_c[2]\);
    
    PCLK_ibuf_RNIFTKQ4 : GB_NG
      port map(An => \AFLSDF_INV_0\, ENn => \GND\, YNn => 
        \PCLK_ibuf_RNIFTKQ4/U0_YNn\, YSn => OPEN);
    
    \PWDATA_ibuf[0]/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => PWDATA(0), Y => \PWDATA_ibuf[0]/U0/YIN1\);
    
    \PRDATA_obuf[1]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[1]/U0/EOUT\);
    
    \PRDATA_obuf[1]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(1), D => \PRDATA_obuf[1]/U0/DOUT\, E
         => \PRDATA_obuf[1]/U0/EOUT\);
    
    \PRDATA_obuf[19]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[19]/U0/EOUT\);
    
    \led_obuf[0]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => led(0), D => \led_obuf[0]/U0/DOUT\, E => 
        \led_obuf[0]/U0/EOUT\);
    
    led_0_sqmuxa : CFG4
      generic map(INIT => x"8000")

      port map(A => led4_Z, B => PWRITE_c, C => PSEL_c, D => 
        PENABLE_c, Y => led_0_sqmuxa_Z);
    
    \PRDATA_obuf[11]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[11]/U0/EOUT\);
    
    \led_obuf[0]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \led_c[0]\, Y => \led_obuf[0]/U0/DOUT\);
    
    \led_Z[0]\ : SLE
      port map(D => \PWDATA_c[0]\, CLK => PCLK_c, EN => 
        led_0_sqmuxa_Z, ALn => PRESETN_c, ADn => \VCC\, SLn => 
        \VCC\, SD => \GND\, LAT => \GND\, Q => \led_c[0]\);
    
    \PRDATA_obuf[23]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[23]/U0/DOUT\);
    
    \PADDR_ibuf[4]/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \PADDR_ibuf[4]/U0/YIN1\, Y => \PADDR_c[4]\);
    
    \led_obuf[2]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => led(2), D => \led_obuf[2]/U0/DOUT\, E => 
        \led_obuf[2]/U0/EOUT\);
    
    \PRDATA_1[3]\ : CFG4
      generic map(INIT => x"0800")

      port map(A => \led_c[3]\, B => led4_Z, C => PWRITE_c, D => 
        PSEL_c, Y => \PRDATA_c[3]\);
    
    \PRDATA_obuf[10]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[10]/U0/DOUT\);
    
    \PRDATA_obuf[18]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[18]/U0/EOUT\);
    
    \PRDATA_obuf[22]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[22]/U0/DOUT\);
    
    \PRDATA_obuf[9]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[9]/U0/EOUT\);
    
    \PRDATA_obuf[31]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(31), D => \PRDATA_obuf[31]/U0/DOUT\, 
        E => \PRDATA_obuf[31]/U0/EOUT\);
    
    \PRDATA_obuf[20]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(20), D => \PRDATA_obuf[20]/U0/DOUT\, 
        E => \PRDATA_obuf[20]/U0/EOUT\);
    
    \PRDATA_obuf[18]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(18), D => \PRDATA_obuf[18]/U0/DOUT\, 
        E => \PRDATA_obuf[18]/U0/EOUT\);
    
    \PRDATA_obuf[15]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[15]/U0/EOUT\);
    
    \PRDATA_obuf[12]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(12), D => \PRDATA_obuf[12]/U0/DOUT\, 
        E => \PRDATA_obuf[12]/U0/EOUT\);
    
    \PRDATA_obuf[3]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(3), D => \PRDATA_obuf[3]/U0/DOUT\, E
         => \PRDATA_obuf[3]/U0/EOUT\);
    
    \PREADY_obuf/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \VCC\, Y => \PREADY_obuf/U0/DOUT\);
    
    \PWDATA_ibuf[0]/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \PWDATA_ibuf[0]/U0/YIN1\, Y => \PWDATA_c[0]\);
    
    \PSEL_ibuf/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \PSEL_ibuf/U0/YIN1\, Y => PSEL_c);
    
    \PRDATA_obuf[18]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[18]/U0/DOUT\);
    
    \PRDATA_obuf[14]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(14), D => \PRDATA_obuf[14]/U0/DOUT\, 
        E => \PRDATA_obuf[14]/U0/EOUT\);
    
    \PRDATA_obuf[29]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[29]/U0/DOUT\);
    
    \led_Z[2]\ : SLE
      port map(D => \PWDATA_c[2]\, CLK => PCLK_c, EN => 
        led_0_sqmuxa_Z, ALn => PRESETN_c, ADn => \VCC\, SLn => 
        \VCC\, SD => \GND\, LAT => \GND\, Q => \led_c[2]\);
    
    \PWRITE_ibuf/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => PWRITE, Y => \PWRITE_ibuf/U0/YIN1\);
    
    \PWDATA_ibuf[1]/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \PWDATA_ibuf[1]/U0/YIN1\, Y => \PWDATA_c[1]\);
    
    \led_obuf[2]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \led_c[2]\, Y => \led_obuf[2]/U0/DOUT\);
    
    \PRDATA_obuf[27]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(27), D => \PRDATA_obuf[27]/U0/DOUT\, 
        E => \PRDATA_obuf[27]/U0/EOUT\);
    
    \led_obuf[1]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \led_c[1]\, Y => \led_obuf[1]/U0/DOUT\);
    
    \PRDATA_obuf[26]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[26]/U0/DOUT\);
    
    \PADDR_ibuf[0]/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => PADDR(0), Y => \PADDR_ibuf[0]/U0/YIN1\);
    
    \PRDATA_obuf[4]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[4]/U0/DOUT\);
    
    \PRDATA_obuf[27]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[27]/U0/DOUT\);
    
    \PRDATA_obuf[29]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[29]/U0/EOUT\);
    
    \PRDATA_obuf[30]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[30]/U0/EOUT\);
    
    \PWDATA_ibuf[2]/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => PWDATA(2), Y => \PWDATA_ibuf[2]/U0/YIN1\);
    
    \PRDATA_obuf[15]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(15), D => \PRDATA_obuf[15]/U0/DOUT\, 
        E => \PRDATA_obuf[15]/U0/EOUT\);
    
    \PRDATA_obuf[21]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[21]/U0/EOUT\);
    
    \PRDATA_obuf[8]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[8]/U0/EOUT\);
    
    \PENABLE_ibuf/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => PENABLE, Y => \PENABLE_ibuf/U0/YIN1\);
    
    \PADDR_ibuf[6]/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \PADDR_ibuf[6]/U0/YIN1\, Y => \PADDR_c[6]\);
    
    \PRDATA_obuf[6]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[6]/U0/DOUT\);
    
    ip_interface_inst : IP_INTERFACE
      port map(A => \VCC\, B => ff_to_start_net, C => \VCC\, IPA
         => OPEN, IPB => OPEN, IPC => OPEN);
    
    \led_obuf[3]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \led_obuf[3]/U0/EOUT\);
    
    \PRDATA_obuf[5]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[5]/U0/EOUT\);
    
    \PRDATA_obuf[28]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[28]/U0/EOUT\);
    
    \PRDATA_obuf[10]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[10]/U0/EOUT\);
    
    \PRDATA_obuf[30]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(30), D => \PRDATA_obuf[30]/U0/DOUT\, 
        E => \PRDATA_obuf[30]/U0/EOUT\);
    
    \PRDATA_obuf[0]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \PRDATA_c[0]\, Y => \PRDATA_obuf[0]/U0/DOUT\);
    
    \PRDATA_obuf[14]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[14]/U0/DOUT\);
    
    \PRDATA_obuf[15]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[15]/U0/DOUT\);
    
    \PRDATA_obuf[26]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(26), D => \PRDATA_obuf[26]/U0/DOUT\, 
        E => \PRDATA_obuf[26]/U0/EOUT\);
    
    \PRDATA_obuf[25]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[25]/U0/EOUT\);
    
    \PADDR_ibuf[4]/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => PADDR(4), Y => \PADDR_ibuf[4]/U0/YIN1\);
    
    \PRDATA_obuf[23]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(23), D => \PRDATA_obuf[23]/U0/DOUT\, 
        E => \PRDATA_obuf[23]/U0/EOUT\);
    
    \PRDATA_obuf[7]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[7]/U0/EOUT\);
    
    \PREADY_obuf/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PREADY_obuf/U0/EOUT\);
    
    \PRDATA_obuf[31]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[31]/U0/DOUT\);
    
    \PRDATA_obuf[4]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[4]/U0/EOUT\);
    
    \PRDATA_obuf[13]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[13]/U0/EOUT\);
    
    \PADDR_ibuf[7]/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \PADDR_ibuf[7]/U0/YIN1\, Y => \PADDR_c[7]\);
    
    \PRDATA_obuf[19]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(19), D => \PRDATA_obuf[19]/U0/DOUT\, 
        E => \PRDATA_obuf[19]/U0/EOUT\);
    
    \PRDATA_obuf[3]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[3]/U0/EOUT\);
    
    \PSEL_ibuf/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => PSEL, Y => \PSEL_ibuf/U0/YIN1\);
    
    \PRDATA_1[1]\ : CFG4
      generic map(INIT => x"0800")

      port map(A => \led_c[1]\, B => led4_Z, C => PWRITE_c, D => 
        PSEL_c, Y => \PRDATA_c[1]\);
    
    \PRDATA_obuf[13]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[13]/U0/DOUT\);
    
    \PRDATA_obuf[7]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[7]/U0/DOUT\);
    
    \PRDATA_obuf[21]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[21]/U0/DOUT\);
    
    \PRDATA_obuf[11]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(11), D => \PRDATA_obuf[11]/U0/DOUT\, 
        E => \PRDATA_obuf[11]/U0/EOUT\);
    
    \PRDATA_obuf[0]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(0), D => \PRDATA_obuf[0]/U0/DOUT\, E
         => \PRDATA_obuf[0]/U0/EOUT\);
    
    \PRDATA_obuf[7]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(7), D => \PRDATA_obuf[7]/U0/DOUT\, E
         => \PRDATA_obuf[7]/U0/EOUT\);
    
    \PWDATA_ibuf[1]/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => PWDATA(1), Y => \PWDATA_ibuf[1]/U0/YIN1\);
    
    \PRDATA_obuf[12]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[12]/U0/DOUT\);
    
    \PADDR_ibuf[1]/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => PADDR(1), Y => \PADDR_ibuf[1]/U0/YIN1\);
    
    \PRDATA_obuf[5]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(5), D => \PRDATA_obuf[5]/U0/DOUT\, E
         => \PRDATA_obuf[5]/U0/EOUT\);
    
    \PRDATA_obuf[16]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[16]/U0/EOUT\);
    
    \PADDR_ibuf[1]/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \PADDR_ibuf[1]/U0/YIN1\, Y => \PADDR_c[1]\);
    
    \PRDATA_obuf[8]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(8), D => \PRDATA_obuf[8]/U0/DOUT\, E
         => \PRDATA_obuf[8]/U0/EOUT\);
    
    \PRDATA_obuf[20]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[20]/U0/EOUT\);
    
    \PRDATA_obuf[28]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(28), D => \PRDATA_obuf[28]/U0/DOUT\, 
        E => \PRDATA_obuf[28]/U0/EOUT\);
    
    \PRDATA_obuf[22]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(22), D => \PRDATA_obuf[22]/U0/DOUT\, 
        E => \PRDATA_obuf[22]/U0/EOUT\);
    
    \PRDATA_obuf[12]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[12]/U0/EOUT\);
    
    \led_obuf[2]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \led_obuf[2]/U0/EOUT\);
    
    \PRDATA_obuf[19]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[19]/U0/DOUT\);
    
    \PRESETN_ibuf/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => PRESETN, Y => \PRESETN_ibuf/U0/YIN1\);
    
    \PRDATA_obuf[24]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(24), D => \PRDATA_obuf[24]/U0/DOUT\, 
        E => \PRDATA_obuf[24]/U0/EOUT\);
    
    \PRDATA_obuf[17]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[17]/U0/EOUT\);
    
    \PRDATA_obuf[2]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[2]/U0/EOUT\);
    
    \PRDATA_obuf[3]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \PRDATA_c[3]\, Y => \PRDATA_obuf[3]/U0/DOUT\);
    
    \PRDATA_obuf[14]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[14]/U0/EOUT\);
    
    \flash_freeze_inst/INST_FLASH_FREEZE_IP\ : FLASH_FREEZE
      port map(FF_TO_START => ff_to_start_net, FF_DONE => OPEN);
    
    \led_obuf[0]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \led_obuf[0]/U0/EOUT\);
    
    \PRDATA_obuf[30]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[30]/U0/DOUT\);
    
    led4 : CFG4
      generic map(INIT => x"0008")

      port map(A => led4_4_Z, B => led4_3_Z, C => \PADDR_c[5]\, D
         => \PADDR_c[4]\, Y => led4_Z);
    
    \PCLK_ibuf/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => PCLK_ibuf_Z, Y => \PCLK_ibuf/U0/YIN\);
    
    \PRDATA_obuf[9]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[9]/U0/DOUT\);
    
    \PRDATA_obuf[16]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[16]/U0/DOUT\);
    
    \PWDATA_ibuf[3]/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => PWDATA(3), Y => \PWDATA_ibuf[3]/U0/YIN1\);
    
    \PRESETN_ibuf/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \PRESETN_ibuf/U0/YIN1\, Y => PRESETN_c);
    
    \PWDATA_ibuf[3]/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \PWDATA_ibuf[3]/U0/YIN1\, Y => \PWDATA_c[3]\);
    
    \PRDATA_obuf[17]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[17]/U0/DOUT\);
    
    \PRDATA_obuf[23]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[23]/U0/EOUT\);
    
    \PRDATA_obuf[20]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[20]/U0/DOUT\);
    
    led4_3 : CFG2
      generic map(INIT => x"1")

      port map(A => \PADDR_c[6]\, B => \PADDR_c[7]\, Y => 
        led4_3_Z);
    
    led4_4 : CFG4
      generic map(INIT => x"0001")

      port map(A => \PADDR_c[3]\, B => \PADDR_c[2]\, C => 
        \PADDR_c[1]\, D => \PADDR_c[0]\, Y => led4_4_Z);
    
    \PADDR_ibuf[2]/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => PADDR(2), Y => \PADDR_ibuf[2]/U0/YIN1\);
    
    \PRDATA_obuf[10]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(10), D => \PRDATA_obuf[10]/U0/DOUT\, 
        E => \PRDATA_obuf[10]/U0/EOUT\);
    
    \PREADY_obuf/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PREADY, D => \PREADY_obuf/U0/DOUT\, E => 
        \PREADY_obuf/U0/EOUT\);
    
    \PRDATA_obuf[25]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(25), D => \PRDATA_obuf[25]/U0/DOUT\, 
        E => \PRDATA_obuf[25]/U0/EOUT\);
    
    \PRDATA_obuf[4]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(4), D => \PRDATA_obuf[4]/U0/DOUT\, E
         => \PRDATA_obuf[4]/U0/EOUT\);
    
    \PRDATA_obuf[8]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[8]/U0/DOUT\);
    
    \PRDATA_obuf[6]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \PRDATA_obuf[6]/U0/EOUT\);
    
    \PRDATA_obuf[28]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \GND\, Y => \PRDATA_obuf[28]/U0/DOUT\);
    
    \PRDATA_obuf[2]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(2), D => \PRDATA_obuf[2]/U0/DOUT\, E
         => \PRDATA_obuf[2]/U0/EOUT\);
    
    \PRDATA_obuf[17]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => PRDATA(17), D => \PRDATA_obuf[17]/U0/DOUT\, 
        E => \PRDATA_obuf[17]/U0/EOUT\);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);

    VCC_power_inst1 : VCC
      port map( Y => VCC_power_net1);


end DEF_ARCH; 
