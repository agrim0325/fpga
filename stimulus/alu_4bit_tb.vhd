library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu_4bit_tb is
end alu_4bit_tb;

architecture sim of alu_4bit_tb is
    component alu_4bit
        port(A, B  : in  STD_LOGIC_VECTOR(3 downto 0);
             opcode: in  STD_LOGIC_VECTOR(3 downto 0);
             result: out STD_LOGIC_VECTOR(3 downto 0);
             carry, zero, neg, ovflow: out STD_LOGIC);
    end component;

    signal A, B, op, res : STD_LOGIC_VECTOR(3 downto 0);
    signal C, Z, N, OV   : STD_LOGIC;

begin
    DUT: alu_4bit port map(A, B, op, res, C, Z, N, OV);

    stim: process
    begin
        -- ADD 5+3=8
        A<="0101"; B<="0011"; op<="0000"; wait for 20 ns;
        assert res="1000" report "ADD failed" severity error;

        -- SUB 5-3=2
        A<="0101"; B<="0011"; op<="0001"; wait for 20 ns;
        assert res="0010" report "SUB failed" severity error;

        -- INC 5+1=6
        A<="0101"; B<="0000"; op<="0010"; wait for 20 ns;
        assert res="0110" report "INC failed" severity error;

        -- AND 5 AND 3=1
        A<="0101"; B<="0011"; op<="0100"; wait for 20 ns;
        assert res="0001" report "AND failed" severity error;

        -- OR 5 OR 3=7
        A<="0101"; B<="0011"; op<="0101"; wait for 20 ns;
        assert res="0111" report "OR failed" severity error;

        -- XOR 5 XOR 3=6
        A<="0101"; B<="0011"; op<="0110"; wait for 20 ns;
        assert res="0110" report "XOR failed" severity error;

        -- SHL 5=0101 -> 1010
        A<="0101"; B<="0000"; op<="1000"; wait for 20 ns;
        assert res="1010" report "SHL failed" severity error;

        -- Carry: 15+1 overflows
        A<="1111"; B<="0001"; op<="0000"; wait for 20 ns;
        assert C='1' report "Carry failed" severity error;

        -- Zero flag: 5-5=0
        A<="0101"; B<="0101"; op<="0001"; wait for 20 ns;
        assert Z='1' report "Zero flag failed" severity error;

        -- EQ: 5=5 -> result=1
        A<="0101"; B<="0101"; op<="1100"; wait for 20 ns;
        assert res="0001" report "EQ failed" severity error;

        assert false report "All ALU tests passed" severity failure;
    end process;
end sim;