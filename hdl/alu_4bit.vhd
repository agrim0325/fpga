library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu_4bit is
    Port (
        A, B    : in  STD_LOGIC_VECTOR(3 downto 0);
        opcode  : in  STD_LOGIC_VECTOR(3 downto 0);
        result  : out STD_LOGIC_VECTOR(3 downto 0);
        carry   : out STD_LOGIC;
        zero    : out STD_LOGIC;
        neg     : out STD_LOGIC;
        ovflow  : out STD_LOGIC
    );
end alu_4bit;

architecture Behavioral of alu_4bit is
    signal res5 : unsigned(4 downto 0);
    signal res4 : STD_LOGIC_VECTOR(3 downto 0);
begin
    process(A, B, opcode)
    begin
        res5 <= (others => '0');
        case opcode is
            when "0000" => res5 <= ('0' & unsigned(A)) + ('0' & unsigned(B));
            when "0001" => res5 <= ('0' & unsigned(A)) - ('0' & unsigned(B));
            when "0010" => res5 <= ('0' & unsigned(A)) + 1;
            when "0011" => res5 <= ('0' & unsigned(A)) - 1;
            when "0100" => res5 <= '0' & (unsigned(A) and  unsigned(B));
            when "0101" => res5 <= '0' & (unsigned(A) or   unsigned(B));
            when "0110" => res5 <= '0' & (unsigned(A) xor  unsigned(B));
            when "0111" => res5 <= '0' & unsigned(not A);
            when "1000" => res5 <= '0' & unsigned(A(2 downto 0) & '0');
            when "1001" => res5 <= '0' & unsigned('0' & A(3 downto 1));
            when "1010" => res5 <= '0' & unsigned(A(2 downto 0) & A(3));
            when "1011" => res5 <= '0' & unsigned(A(0) & A(3 downto 1));
            when "1100" => if A = B then res5 <= "00001"; else res5 <= "00000"; end if;
            when "1101" => if A > B then res5 <= "00001"; else res5 <= "00000"; end if;
            when "1110" => if A < B then res5 <= "00001"; else res5 <= "00000"; end if;
            when others => res5 <= (others => '0');
        end case;
    end process;

    res4   <= STD_LOGIC_VECTOR(res5(3 downto 0));
    result <= res4;
    carry  <= res5(4);
    zero   <= '1' when res4 = "0000" else '0';
    neg    <= res4(3);
    ovflow <= res5(4) xor res4(3);
end Behavioral;