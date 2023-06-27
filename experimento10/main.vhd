library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity calculadora is
	port(sw: in std_logic_vector (3 downto 0);
		numero2: in std_logic_vector (3 downto 0);
		operacao: in std_logic;
		led: out std_logic;
		an: out std_logic_vector (3 downto 0);
		clk: in STD_LOGIC;
		seg: out std_logic_vector (6 downto 0));

end calculadora;


architecture Behavioral of calculadora is

signal output: std_logic_vector(6 downto 0);
signal output1: std_logic_vector(6 downto 0);
signal output3: std_logic_vector(6 downto 0); -- sinal que será enviado ao display
signal sum_result: std_logic_vector(3 downto 0) := "0000"; -- resultado, deve ser ligado o último display
signal cycles_50hz: positive range 1 to 200000 := 1;
signal counter_50hz: positive range 1 to 4 := 1;
signal overflow_occurred: std_logic;

signal display_id: positive range 1 to 4 := 1;

component somador_umbit is
  Port (a, b: in std_logic;
      sig: in std_logic; -- sinal da operação
      result: out std_logic;
      carry: out std_logic);
end component;

begin

    -- Lê os bits do primeiro número
    output <= "1000000" when sw = "0000" else
    "1111001" when sw = "0001" else
    "0100100" when sw = "0010" else
    "0110000" when sw = "0011" else
    "0011001" when sw = "0100" else
    "0010010" when sw = "0101" else
    "0000010" when sw = "0110" else
    "1111000" when sw = "0111" else
    "0000000" when sw = "1000" else
    "0010000" when sw = "1001";

    -- Lê os bits do segundo número
    output1 <=
    "1000000" when numero2 = "0000" else
    "1111001" when numero2 = "0001" else
    "0100100" when numero2 = "0010" else
    "0110000" when numero2 = "0011" else
    "0011001" when numero2 = "0100" else
    "0010010" when numero2 = "0101" else
    "0000010" when numero2 = "0110" else
    "1111000" when numero2 = "0111" else
    "0000000" when numero2 = "1000" else
    "0010000" when numero2 = "1001";

    -- mapeia o somador de 1 bit para cada valor da entrada nas chaves
    s1: somador_umbit port map(a => sw(0), b => numero2(0), sig => operacao, result => sum_result(0), carry => open);
    s2: somador_umbit port map(a => sw(1), b => numero2(1), sig => operacao, result => sum_result(1), carry => open);
    s3: somador_umbit port map(a => sw(2), b => numero2(2), sig => operacao, result => sum_result(2), carry => open);
    s4: somador_umbit port map(a => sw(3), b => numero2(3), sig => operacao, result => sum_result(3), carry => overflow_occurred);

    output3 <=
    "1000000" when sum_result = "0000" else
    "1111001" when sum_result = "0001" else
    "0100100" when sum_result = "0010" else
    "0110000" when sum_result = "0011" else
    "0011001" when sum_result = "0100" else
    "0010010" when sum_result = "0101" else
    "0000010" when sum_result = "0110" else
    "1111000" when sum_result = "0111" else
    "0000000" when sum_result = "1000" else
    "0010000" when sum_result = "1001" else
    "1111111"; -- desliga o display quando dá overflow


    run_all: process(clk)
    begin
        if rising_edge(clk) then
            if cycles_50hz = 200000 then
                -- zera o contador
                counter_50hz <= 1;

                case display_id is
                    when 1 => an <= "0111"; seg <= output;
                    when 2 => an <= "1011"; seg <= output1;
                    when 3 => an <= "1111";
                    when 4 => an <= "1110"; seg <= output3;
                    when others => an <= "1111";
                end case;

                if display_id = 4 then
                    display_id <= 1;
                else
                    display_id <= display_id + 1;
                end if;
            end if;

            -- incrementa o contador de clock
            cycles_50hz <= cycles_50hz + 1;
        end if;

     end process;



end Behavioral;