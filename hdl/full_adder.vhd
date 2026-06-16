
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- 1-bit full adder. The ALU will use 4 of these.
entity full_adder is
    Port (
        a, b, cin  : in  STD_LOGIC;
        sum, cout  : out STD_LOGIC
    );
end full_adder;

architecture Behavioral of full_adder is
begin
    sum  <= a XOR b XOR cin;
    cout <= (a AND b) OR (cin AND (a XOR b));
end Behavioral;