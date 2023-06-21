library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity calculadora is
	port(numberA: in std_logic_vector (7 downto 0);
		numberB: in std_logic_vector (3 downto 0);
		operation: in std_logic;
		overflow_indicator: out std_logic;
		an: out std_logic_vector (3 downto 0);
		seg: out std_logic_vector (6 downto 0));

end calculadora;


architecture Behavioral of calculadora is
	

end Behavioral;