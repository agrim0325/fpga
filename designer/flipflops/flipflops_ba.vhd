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

  component sdf_IOPAD_IN
    port( PAD : in    std_logic := 'U';
          Y   : out   std_logic
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

  component IOINFF_BYPASS
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

  component CFG1
    generic (INIT:std_logic_vector(1 downto 0) := "00");

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

  component GB_NG
    port( An  : in    std_logic := 'U';
          ENn : in    std_logic := 'U';
          YNn : out   std_logic;
          YSn : out   std_logic
        );
  end component;

  component IOOUTFF_BYPASS
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component IOENFF_BYPASS
    port( A : in    std_logic := 'U';
          Y : out   std_logic
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

    signal \VCC\, \GND\, q_jk_reg_3, q_t_reg_0_Z, 
        \clk_ibuf_RNIVTI21/U0_YNn\, rst_c, d_c, NN_1, NN_2, t_c, 
        s_c, r_c, q_d_c, q_jk_c, q_t_c, q_sr_c, r_c_i, 
        q_sr_reg3_i_Z, q_jk_reg3_i_Z, ff_to_start_net, clk_ibuf_Z, 
        \clk_ibuf/U0/YIN\, \r_ibuf/U0/YIN1\, \t_ibuf/U0/YIN1\, 
        \d_ibuf/U0/YIN1\, \s_ibuf/U0/YIN1\, \q_sr_obuf/U0/DOUT\, 
        \q_sr_obuf/U0/EOUT\, \q_d_obuf/U0/DOUT\, 
        \q_d_obuf/U0/EOUT\, \rst_ibuf/U0/YIN1\, \k_ibuf/U0/YIN1\, 
        \q_jk_obuf/U0/DOUT\, \q_jk_obuf/U0/EOUT\, 
        \q_t_obuf/U0/DOUT\, \q_t_obuf/U0/EOUT\, \j_ibuf/U0/YIN1\, 
        clk_c, AFLSDF_VCC, AFLSDF_GND, \AFLSDF_INV_0\, 
        \AFLSDF_INV_1\, \AFLSDF_INV_2\, \AFLSDF_INV_3\, 
        \AFLSDF_INV_4\ : std_logic;
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

    q_t_reg : SLE
      port map(D => q_t_reg_0_Z, CLK => clk_c, EN => \VCC\, ALn
         => \AFLSDF_INV_0\, ADn => \VCC\, SLn => \VCC\, SD => 
        \GND\, LAT => \GND\, Q => q_t_c);
    
    \j_ibuf/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => j, Y => \j_ibuf/U0/YIN1\);
    
    \clk_ibuf_RNIVTI21/U0_RGB1\ : RGB_NG
      port map(An => \clk_ibuf_RNIVTI21/U0_YNn\, ENn => \GND\, YL
         => clk_c, YR => OPEN);
    
    AFLSDF_INV_2 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_2\);
    
    \rst_ibuf/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \rst_ibuf/U0/YIN1\, Y => rst_c);
    
    q_jk_reg_3_f0 : CFG3
      generic map(INIT => x"2A")

      port map(A => NN_1, B => q_jk_c, C => NN_2, Y => q_jk_reg_3);
    
    q_sr_reg_RNO : CFG1
      generic map(INIT => "01")

      port map(A => r_c, Y => r_c_i);
    
    \q_sr_obuf/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => q_sr, D => \q_sr_obuf/U0/DOUT\, E => 
        \q_sr_obuf/U0/EOUT\);
    
    \k_ibuf/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => k, Y => \k_ibuf/U0/YIN1\);
    
    \r_ibuf/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \r_ibuf/U0/YIN1\, Y => r_c);
    
    \r_ibuf/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => r, Y => \r_ibuf/U0/YIN1\);
    
    clk_ibuf_RNIVTI21 : GB_NG
      port map(An => \AFLSDF_INV_1\, ENn => \GND\, YNn => 
        \clk_ibuf_RNIVTI21/U0_YNn\, YSn => OPEN);
    
    \t_ibuf/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => t, Y => \t_ibuf/U0/YIN1\);
    
    \d_ibuf/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => d, Y => \d_ibuf/U0/YIN1\);
    
    \q_jk_obuf/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => q_jk_c, Y => \q_jk_obuf/U0/DOUT\);
    
    \q_t_obuf/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => q_t, D => \q_t_obuf/U0/DOUT\, E => 
        \q_t_obuf/U0/EOUT\);
    
    \q_jk_obuf/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => q_jk, D => \q_jk_obuf/U0/DOUT\, E => 
        \q_jk_obuf/U0/EOUT\);
    
    \t_ibuf/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \t_ibuf/U0/YIN1\, Y => t_c);
    
    \q_d_obuf/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \q_d_obuf/U0/EOUT\);
    
    q_d_reg : SLE
      port map(D => d_c, CLK => clk_c, EN => \VCC\, ALn => 
        \AFLSDF_INV_2\, ADn => \VCC\, SLn => \VCC\, SD => \GND\, 
        LAT => \GND\, Q => q_d_c);
    
    \flash_freeze_inst/INST_FLASH_FREEZE_IP\ : FLASH_FREEZE
      port map(FF_TO_START => ff_to_start_net, FF_DONE => OPEN);
    
    \s_ibuf/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \s_ibuf/U0/YIN1\, Y => s_c);
    
    q_jk_reg : SLE
      port map(D => q_jk_reg_3, CLK => clk_c, EN => q_jk_reg3_i_Z, 
        ALn => \AFLSDF_INV_3\, ADn => \VCC\, SLn => \VCC\, SD => 
        \GND\, LAT => \GND\, Q => q_jk_c);
    
    q_jk_reg3_i : CFG2
      generic map(INIT => x"E")

      port map(A => NN_1, B => NN_2, Y => q_jk_reg3_i_Z);
    
    AFLSDF_INV_3 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_3\);
    
    \q_d_obuf/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => q_d_c, Y => \q_d_obuf/U0/DOUT\);
    
    AFLSDF_INV_0 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_0\);
    
    \q_sr_obuf/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \q_sr_obuf/U0/EOUT\);
    
    \clk_ibuf/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => clk, Y => clk_ibuf_Z);
    
    \s_ibuf/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => s, Y => \s_ibuf/U0/YIN1\);
    
    q_t_reg_0 : CFG2
      generic map(INIT => x"6")

      port map(A => q_t_c, B => t_c, Y => q_t_reg_0_Z);
    
    \rst_ibuf/U0/U_IOPAD\ : sdf_IOPAD_IN
      port map(PAD => rst, Y => \rst_ibuf/U0/YIN1\);
    
    \j_ibuf/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \j_ibuf/U0/YIN1\, Y => NN_1);
    
    q_sr_reg : SLE
      port map(D => r_c_i, CLK => clk_c, EN => q_sr_reg3_i_Z, ALn
         => \AFLSDF_INV_4\, ADn => \VCC\, SLn => \VCC\, SD => 
        \GND\, LAT => \GND\, Q => q_sr_c);
    
    AFLSDF_INV_1 : INV_BA
      port map(A => clk_ibuf_Z, Y => \AFLSDF_INV_1\);
    
    \q_d_obuf/U0/U_IOPAD\ : sdf_IOPAD_TRI
      port map(PAD => q_d, D => \q_d_obuf/U0/DOUT\, E => 
        \q_d_obuf/U0/EOUT\);
    
    \q_t_obuf/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \q_t_obuf/U0/EOUT\);
    
    \q_t_obuf/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => q_t_c, Y => \q_t_obuf/U0/DOUT\);
    
    \k_ibuf/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \k_ibuf/U0/YIN1\, Y => NN_2);
    
    ip_interface_inst : IP_INTERFACE
      port map(A => \VCC\, B => ff_to_start_net, C => \VCC\, IPA
         => OPEN, IPB => OPEN, IPC => OPEN);
    
    \clk_ibuf/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => clk_ibuf_Z, Y => \clk_ibuf/U0/YIN\);
    
    \q_sr_obuf/U0/U_IOOUTFF\ : IOOUTFF_BYPASS
      port map(A => q_sr_c, Y => \q_sr_obuf/U0/DOUT\);
    
    AFLSDF_INV_4 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_4\);
    
    q_sr_reg3_i : CFG2
      generic map(INIT => x"E")

      port map(A => r_c, B => s_c, Y => q_sr_reg3_i_Z);
    
    \q_jk_obuf/U0/U_IOENFF\ : IOENFF_BYPASS
      port map(A => \VCC\, Y => \q_jk_obuf/U0/EOUT\);
    
    \d_ibuf/U0/U_IOINFF\ : IOINFF_BYPASS
      port map(A => \d_ibuf/U0/YIN1\, Y => d_c);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);

    VCC_power_inst1 : VCC
      port map( Y => VCC_power_net1);


end DEF_ARCH; 
