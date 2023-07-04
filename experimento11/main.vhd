library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registrador is
    Port ( clock   : in  STD_LOGIC;
           reset   : in  STD_LOGIC;
           shiftIn : in  STD_LOGIC;
           leds    : out STD_LOGIC_VECTOR (15 downto 0)
         );
end ShiftRegister;

architecture Behavioral of ShiftRegister is
    signal register : STD_LOGIC_VECTOR (15 downto 0);
    signal internalClock : STD_LOGIC;
begin
    -- Divisor para gerar um sinal de clock de 1 MHz
    constant clkDivisor : integer := 500000;

    process (clock, reset)
    begin
        if reset = '1' then
            register <= (others => '0');  -- reinicializar o registrador
        elsif rising_edge(clock) then
            internalClock <= not internalClock;  -- gerar sinal de clock interno

            if internalClock = '1' then
                register <= shiftIn & register(15 downto 1);  -- deslocar os bits
            end if;
        end if;
    end process;

    leds <= register;
end Behavioral;
