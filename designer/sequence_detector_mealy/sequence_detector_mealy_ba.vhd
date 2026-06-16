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

entity sequence_detector_mealy is

    port( clk    : in    std_logic;
          rst    : in    std_logic;
          din    : in    std_logic;
          detect : out   std_logic
        );

end sequence_detector_mealy;

architecture DEF_ARCH of sequence_detector_mealy is 

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

  component IOENFF_BYPASS
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component IOINFF_BYPASS
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component sdf_IOPAD_IN
    port( PAD : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component INV_BA
    port( A : in    std_logic := 'U';
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

  component IP_INTERFACE
    port( A   : in    std_logic := 'U';
          B   : in    std_logic := 'U';
          C   : in    std_logic := 'U';
          IPA : out   std_logic;
          IPB : out   std_logic;
          IPC : out   std_logic
        );
  end component;

  component sdf_IOPAD_TRI
    port( PAD : out   std_logic;
          D   : in    std_logic := 'U';
          E   : in    std_logic := 'U'
        );
  end component;

  component RGB_NG
    port( An  : in    std_logic := 'U';
          ENn : in    std_logic := 'U';
          YL  : out   std_logic;
          YR  : out   std_logic
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

  component GB_NG
    port( An  : in    std_logic := 'U';
          ENn : in    std_logic := 'U';
          YNn : out   std_logic;
          YSn : out   std_logic
        );
  end component;

  component GND
    port(Y : out std_logic); 
  end component;

  component VCC
    port(Y : out std_logic); 
  end component;

    signal \state_Z[1]\, \state_Z[0]\, \state_ns[1]\, \GND\, 
        \VCC\, \clk_ibuf_RNIVTI21/U0_YNn\, rst_c, NN_1, detect_c, 
        ff_to_start_net, clk_ibuf_Z, \clk_ibuf/U0/YIN\, 
        \detect_obuf/U0/DOUT\, \detect_obuf/U0/EOUT\, 
        \din_ibuf/U0/YIN1\, \rst_ibuf/U0/YIN1\, clk_c, AFLSDF_VCC, 
        AFLSDF_GND, \AFLSDF_INV_0\, \AFLSDF_INV_1\, 
        \AFLSDF_INV_2\ : std_logic;
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

    \state[1]\ : SLE
      port map(D => \state_ns[1]\, CLK => clk_c, EN => \VCC\, ALn
         => \AFLSDF_INV_0\, ADn => \VCC\, SLn => \VCC\, SD => 
        \GND\, LAT => \GND\, Q => \state_Z[1]\);
    
    \detect_obuf/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \detect_obuf/U0/EOUT\);
    
    \rst_ibuf/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \rst_ibuf/U0/YIN1\, Y => rst_c);
    
    \din_ibuf/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => din, Y => \din_ibuf/U0/YIN1\);
    
    AFLSDF_INV_1 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_1\);
    
    \state_ns_1_0_.m2\ : CFG3
      generic map(INIT => x"62")

      port map(A => \state_Z[0]\, B => NN_1, C => \state_Z[1]\, Y
         => \state_ns[1]\);
    
    ip_interface_inst : IP_INTERFACE
      port map(A => \VCC\, B => ff_to_start_net, C => \VCC\, IPA
         => OPEN, IPB => OPEN, IPC => OPEN);
    
    state_tr4 : CFG3
      generic map(INIT => x"80")

      port map(A => \state_Z[1]\, B => \state_Z[0]\, C => NN_1, Y
         => detect_c);
    
    \clk_ibuf/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => clk_ibuf_Z, Y => \clk_ibuf/U0/YIN\);
    
    AFLSDF_INV_0 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_0\);
    
    AFLSDF_INV_2 : INV_BA
      port map(A => clk_ibuf_Z, Y => \AFLSDF_INV_2\);
    
    \din_ibuf/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \din_ibuf/U0/YIN1\, Y => NN_1);
    
    \detect_obuf/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => detect, D => \detect_obuf/U0/DOUT\, E => 
        \detect_obuf/U0/EOUT\);
    
    \clk_ibuf_RNIVTI21/U0_RGB1\ : RGB_NG
      port map(An => \clk_ibuf_RNIVTI21/U0_YNn\, ENn => \GND\, YL
         => clk_c, YR => OPEN);
    
    \flash_freeze_inst/INST_FLASH_FREEZE_IP\ : FLASH_FREEZE
      port map(FF_TO_START => ff_to_start_net, FF_DONE => OPEN);
    
    \detect_obuf/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => detect_c, Y => \detect_obuf/U0/DOUT\);
    
    \clk_ibuf/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => clk, Y => clk_ibuf_Z);
    
    \state[0]\ : SLE
      port map(D => NN_1, CLK => clk_c, EN => \VCC\, ALn => 
        \AFLSDF_INV_1\, ADn => \VCC\, SLn => \VCC\, SD => \GND\, 
        LAT => \GND\, Q => \state_Z[0]\);
    
    clk_ibuf_RNIVTI21 : GB_NG
      port map(An => \AFLSDF_INV_2\, ENn => \GND\, YNn => 
        \clk_ibuf_RNIVTI21/U0_YNn\, YSn => OPEN);
    
    \rst_ibuf/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => rst, Y => \rst_ibuf/U0/YIN1\);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);

    VCC_power_inst1 : VCC
      port map( Y => VCC_power_net1);


end DEF_ARCH; 
