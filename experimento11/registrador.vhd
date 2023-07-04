library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity registrador is
  Port (clk: in std_logic;
        input: in std_logic;
        reset: in std_logic;
        led: out std_logic_vector (15 downto 0));
end registrador;

architecture Behavioral of registrador is

signal cycles_1hz: positive range 1 to 1000000000 := 1;
signal counter_1hz: positive range 1 to 4 := 1;

begin

    run_all: process(clk)
    variable max_counter_value: positive range 1 to 1000000000;
    begin
        if rising_edge(clk) then
            if cycles_1hz = max_counter_value then
                -- reinicia
                counter_1hz <= 1;
                
                if input = '1' and reset = '0' then
                    led <= "111111111111111";
                end if;
            end if;

            -- incrementa o contador de clock
            cycles_1hz <= cycles_1hz + 1;
        end if;

     end process;

end Behavioral;
