library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decodificador_bcd is
    Port ( sw : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an: out STD_LOGIC_VECTOR (3 downto 0);
           chave_multiplexador: in STD_LOGIC);
end decodificador_bcd;

architecture Behavioral of decodificador_bcd is

begin
    
    an <= 
        "1110" when chave_multiplexador = '1' else
        "1101" when chave_multiplexador = '0';
    
    seg <=
        "1000000" when sw = "0000" else
        "1111001" when sw = "0001" else
        "0100100" when sw = "0010" else
        "0110000" when sw = "0011" else
        "0011001" when sw = "0100" else
        "0010010" when sw = "0101" else
        "0000010" when sw = "0110" else
        "1111000" when sw = "0111" else
        "0000000" when sw = "1000";
        
end Behavioral;
