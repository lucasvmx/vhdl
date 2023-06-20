library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
    Port ( clk: in STD_LOGIC;
            seg: out STD_LOGIC_VECTOR (6 downto 0);
            an: out STD_LOGIC_VECTOR (6 downto 0));
end main;
    
architecture Behavioral of main is

-- dígitos da matrícula
signal d1: std_logic_vector (6 downto 0) := "1111001";
signal d2: std_logic_vector (6 downto 0) := "1111001";
signal d3: std_logic_vector (6 downto 0) := "0110000";
signal d4: std_logic_vector (6 downto 0) := "0000010";

signal cycles_05hz: positive range 1 to 200000000 := 1;
signal cycles_50hz: positive range 1 to 200000 := 1;
signal counter_05hz: positive range 1 to 4 := 1;
signal counter_50hz: positive range 1 to 4 := 1;

signal change_display: positive range 1 to 4 := 1;
signal change_display_4d: positive range 1 to 4 := 1;

signal show_register: STD_LOGIC := '0';
signal show_experiment_number: STD_LOGIC := '1';
signal shutdown_display: STD_LOGIC := '0';

begin
    
    run_all: process(clk)
    begin     
        if rising_edge(clk) then
            if cycles_05hz = 200000000 then
                cycles_05hz <= 1;
                
                -- 2 segundos se passaram
                if shutdown_display = '1' then
                    change_display_4d <= 5;
                    shutdown_display <= '0';
                else
                    show_experiment_number <= not show_experiment_number;
                    show_register <= not show_register;
                end if;
                
            elsif cycles_50hz = 200000 and shutdown_display = '0' then
                -- zera o contador
                counter_50hz <= 1;
                
                if show_experiment_number = '1' and change_display = 1 then
                    change_display <= 2;
                elsif show_experiment_number = '1' and change_display = 2 then
                    change_display <= 1;
                elsif show_register = '1' then
                    case change_display_4d is
                        when 1 => change_display_4d <= change_display_4d + 1;
                        when 2 => change_display_4d <= change_display_4d + 1;
                        when 3 => change_display_4d <= change_display_4d + 1;
                        when 4 => change_display_4d <= 1;
                    end case;
                end if;
            end if;
            
            -- incrementa os dois contadores
            cycles_05hz <= cycles_05hz + 1;
            cycles_50hz <= cycles_50hz + 1;
        end if;
        
     end process;
     
     mux_display_two_digits: process(change_display)
     begin
        case change_display is 
            when 1 => an <= "1110"; seg <= "1000000";
            when 2 => an <= "1101"; seg <= "0010000";
        end case;
     end process;
     
     mux_display_four_digits: process(change_display_4d)
     begin
            case change_display_4d is
                when 1 => an <= "1110"; seg <= d1;
                when 2 => an <= "1101"; seg <= d2;
                when 3 => an <= "1011"; seg <= d3;
                when 4 => an <= "0111"; seg <= d4;
                when 5 => an <= "1111";
            end case;
     end process;
end Behavioral;
