----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 06/27/2023 10:27:10 AM
-- Design Name:
-- Module Name: somador_umbit - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity somador_umbit is
  Port (a, b: in std_Logic;
        sig: in std_logic; -- sinal da operação
        result: out std_logic;
        carry: out std_logic);
end somador_umbit;

architecture Behavioral of somador_umbit is
begin
    result <= a xor b xor sig;
    carry <= (a and b) or (a and sig) or (b and sig);
end Behavioral;
