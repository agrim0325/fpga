-- Version: 2025.2 2025.2.0.14
-- File used only for Simulation

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

entity register_4bit is

    port( clk : in    std_logic;
          rst : in    std_logic;
          en  : in    std_logic;
          d   : in    std_logic_vector(3 downto 0);
          q   : out   std_logic_vector(3 downto 0)
        );

end register_4bit;

architecture DEF_ARCH of register_4bit is 

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

  component sdf_IOPAD_IN
    port( PAD : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component IOENFF_BYPASS
    port( A : in    std_logic := 'U';
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

  component GB_NG
    port( An  : in    std_logic := 'U';
          ENn : in    std_logic := 'U';
          YNn : out   std_logic;
          YSn : out   std_logic
        );
  end component;

  component sdf_IOPAD_TRI
    port( PAD : out   std_logic;
          D   : in    std_logic := 'U';
          E   : in    std_logic := 'U'
        );
  end component;

  component FLASH_FREEZE
    port( FF_TO_START : out   std_logic;
          FF_DONE     : out   std_logic
        );
  end component;

  component IOOUTFF_BYPASS
    port( A : in    std_logic := 'U';
          Y : out   std_logic
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

  component GND
    port(Y : out std_logic); 
  end component;

  component VCC
    port(Y : out std_logic); 
  end component;

    signal \d_c[3]\, \d_c[2]\, \d_c[1]\, \d_c[0]\, \q_c[3]\, 
        \q_c[2]\, \q_c[1]\, \q_c[0]\, \GND\, \VCC\, 
        \clk_ibuf_RNIVTI21/U0_YNn\, rst_c, en_c, ff_to_start_net, 
        \d_ibuf[3]/U0/YIN1\, \d_ibuf[1]/U0/YIN1\, 
        \d_ibuf[2]/U0/YIN1\, clk_ibuf_Z, \clk_ibuf/U0/YIN\, 
        \d_ibuf[0]/U0/YIN1\, \q_obuf[3]/U0/DOUT\, 
        \q_obuf[3]/U0/EOUT\, \q_obuf[1]/U0/DOUT\, 
        \q_obuf[1]/U0/EOUT\, \q_obuf[2]/U0/DOUT\, 
        \q_obuf[2]/U0/EOUT\, \rst_ibuf/U0/YIN1\, 
        \q_obuf[0]/U0/DOUT\, \q_obuf[0]/U0/EOUT\, 
        \en_ibuf/U0/YIN1\, clk_c, AFLSDF_VCC, AFLSDF_GND, 
        \AFLSDF_INV_0\, \AFLSDF_INV_1\, \AFLSDF_INV_2\, 
        \AFLSDF_INV_3\, \AFLSDF_INV_4\ : std_logic;
    signal GND_power_net1 : std_logic;
    signal VCC_power_net1 : std_logic;

    for all : sdf_IOPAD_IN
	Use entity work.sdf_IOPAD_IN(DEF_ARCH);
    for all : sdf_IOPAD_TRI
	Use entity work.sdf_IOPAD_TRI(DEF_ARCH);
begin 

    AFLSDF_GND <= GND_power_net1;
    \GND\ <= GND_power_net1;
    \VCC\ <= VCC_power_net1;
    AFLSDF_VCC <= VCC_power_net1;

    \d_ibuf[1]/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \d_ibuf[1]/U0/YIN1\, Y => \d_c[1]\);
    
    \clk_ibuf_RNIVTI21/U0_RGB1\ : RGB_NG
      port map(An => \clk_ibuf_RNIVTI21/U0_YNn\, ENn => \GND\, YL
         => clk_c, YR => OPEN);
    
    AFLSDF_INV_2 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_2\);
    
    \d_ibuf[0]/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => d(0), Y => \d_ibuf[0]/U0/YIN1\);
    
    \d_ibuf[2]/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \d_ibuf[2]/U0/YIN1\, Y => \d_c[2]\);
    
    \rst_ibuf/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \rst_ibuf/U0/YIN1\, Y => rst_c);
    
    \en_ibuf/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => en, Y => \en_ibuf/U0/YIN1\);
    
    \d_ibuf[0]/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \d_ibuf[0]/U0/YIN1\, Y => \d_c[0]\);
    
    \q_obuf[0]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \q_obuf[0]/U0/EOUT\);
    
    \en_ibuf/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \en_ibuf/U0/YIN1\, Y => en_c);
    
    \q_Z[0]\ : SLE
      port map(D => \d_c[0]\, CLK => clk_c, EN => en_c, ALn => 
        \AFLSDF_INV_0\, ADn => \VCC\, SLn => \VCC\, SD => \GND\, 
        LAT => \GND\, Q => \q_c[0]\);
    
    \d_ibuf[2]/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => d(2), Y => \d_ibuf[2]/U0/YIN1\);
    
    clk_ibuf_RNIVTI21 : GB_NG
      port map(An => \AFLSDF_INV_1\, ENn => \GND\, YNn => 
        \clk_ibuf_RNIVTI21/U0_YNn\, YSn => OPEN);
    
    \q_obuf[3]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => q(3), D => \q_obuf[3]/U0/DOUT\, E => 
        \q_obuf[3]/U0/EOUT\);
    
    \q_obuf[1]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => q(1), D => \q_obuf[1]/U0/DOUT\, E => 
        \q_obuf[1]/U0/EOUT\);
    
    \q_obuf[0]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => q(0), D => \q_obuf[0]/U0/DOUT\, E => 
        \q_obuf[0]/U0/EOUT\);
    
    \q_obuf[2]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \q_obuf[2]/U0/EOUT\);
    
    \flash_freeze_inst/INST_FLASH_FREEZE_IP\ : FLASH_FREEZE
      port map(FF_TO_START => ff_to_start_net, FF_DONE => OPEN);
    
    \d_ibuf[3]/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \d_ibuf[3]/U0/YIN1\, Y => \d_c[3]\);
    
    \q_obuf[1]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \q_obuf[1]/U0/EOUT\);
    
    AFLSDF_INV_3 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_3\);
    
    \q_obuf[2]/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => q(2), D => \q_obuf[2]/U0/DOUT\, E => 
        \q_obuf[2]/U0/EOUT\);
    
    \q_obuf[2]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \q_c[2]\, Y => \q_obuf[2]/U0/DOUT\);
    
    AFLSDF_INV_0 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_0\);
    
    \clk_ibuf/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => clk, Y => clk_ibuf_Z);
    
    \q_Z[1]\ : SLE
      port map(D => \d_c[1]\, CLK => clk_c, EN => en_c, ALn => 
        \AFLSDF_INV_2\, ADn => \VCC\, SLn => \VCC\, SD => \GND\, 
        LAT => \GND\, Q => \q_c[1]\);
    
    \q_obuf[3]/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \q_obuf[3]/U0/EOUT\);
    
    \q_obuf[1]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \q_c[1]\, Y => \q_obuf[1]/U0/DOUT\);
    
    \rst_ibuf/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => rst, Y => \rst_ibuf/U0/YIN1\);
    
    AFLSDF_INV_1 : INV_BA
      port map(A => clk_ibuf_Z, Y => \AFLSDF_INV_1\);
    
    ip_interface_inst : IP_INTERFACE
      port map(A => \VCC\, B => ff_to_start_net, C => \VCC\, IPA
         => OPEN, IPB => OPEN, IPC => OPEN);
    
    \clk_ibuf/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => clk_ibuf_Z, Y => \clk_ibuf/U0/YIN\);
    
    \q_obuf[3]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \q_c[3]\, Y => \q_obuf[3]/U0/DOUT\);
    
    \q_Z[3]\ : SLE
      port map(D => \d_c[3]\, CLK => clk_c, EN => en_c, ALn => 
        \AFLSDF_INV_3\, ADn => \VCC\, SLn => \VCC\, SD => \GND\, 
        LAT => \GND\, Q => \q_c[3]\);
    
    \q_Z[2]\ : SLE
      port map(D => \d_c[2]\, CLK => clk_c, EN => en_c, ALn => 
        \AFLSDF_INV_4\, ADn => \VCC\, SLn => \VCC\, SD => \GND\, 
        LAT => \GND\, Q => \q_c[2]\);
    
    \q_obuf[0]/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => \q_c[0]\, Y => \q_obuf[0]/U0/DOUT\);
    
    \d_ibuf[3]/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => d(3), Y => \d_ibuf[3]/U0/YIN1\);
    
    AFLSDF_INV_4 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_4\);
    
    \d_ibuf[1]/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => d(1), Y => \d_ibuf[1]/U0/YIN1\);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);

    VCC_power_inst1 : VCC
      port map( Y => VCC_power_net1);


end DEF_ARCH; 
