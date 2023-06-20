library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
    Port ( clk: in STD_LOGIC;
            seg: out STD_LOGIC_VECTOR (6 downto 0);
            an: out STD_LOGIC_VECTOR (3 downto 0));
end main;

architecture Behavioral of main is

signal cycles_05hz: positive range 1 to 200000000 := 1;
signal cycles_50hz: positive range 1 to 200000 := 1;
signal counter_05hz: positive range 1 to 4 := 1;
signal counter_50hz: positive range 1 to 4 := 1;

signal change_display: positive range 1 to 4 := 1;
signal change_display_4d: positive range 1 to 5 := 1;

signal show_register: STD_LOGIC := '0';
signal show_experiment_number: STD_LOGIC := '1';
signal shutdown_display: STD_LOGIC := '0';

begin

    run_all: process(clk)
    variable counter: natural range 0 to 4 := 0;
    begin
        if rising_edge(clk) then
            if cycles_05hz = 200000000 then
                cycles_05hz <= 1;

                if counter = 2 then
                    an <= "1111";
                    shutdown_display <= '1';
                    counter := counter + 1;
                elsif counter = 3 then
                    counter := 0;
                    shutdown_display <= '0';
                else
                    show_experiment_number <= not show_experiment_number;
                    show_register <= not show_register;

                    -- incrementa a quantidade de vezes que se passaram dois segundos
                    counter := counter + 1;
                end if;
            elsif cycles_50hz = 200000 and shutdown_display = '0' then
                -- zera o contador
                counter_50hz <= 1;

                if show_experiment_number = '1' and change_display = 1 then
                    an <= "1110"; seg <= "1000000";
                    change_display <= 2;
                elsif show_experiment_number = '1' and change_display = 2 then
                    an <= "1101"; seg <= "0010000";
                    change_display <= 1;
                elsif show_register = '1' then
                    case change_display_4d is
                        when 1 => an <= "1110"; seg <= "1111001";
                        when 2 => an <= "1101"; seg <= "1111001";
                        when 3 => an <= "1011"; seg <= "0110000";
                        when 4 => an <= "0111"; seg <= "0000010";
                        when others => an <= "1111";
                    end case;

                    if change_display_4d = 4 then
                        change_display_4d <= 1;
                    else
                        change_display_4d <= change_display_4d + 1;
                    end if;
                end if;
            end if;

            -- incrementa os dois contadores
            cycles_05hz <= cycles_05hz + 1;
            cycles_50hz <= cycles_50hz + 1;
        end if;

     end process;

end Behavioral;
