library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_Register is
    Port (
        clk : in STD_LOGIC;             -- Sinal de clock
        reset : in STD_LOGIC;           -- Sinal de reset
        d : in STD_LOGIC_VECTOR(15 downto 0); -- Dados de entrada
        enable : in STD_LOGIC_VECTOR(15 downto 0); -- Habilita os flip-flops
        q : out STD_LOGIC_VECTOR(15 downto 0)      -- Dados de saída
    );
end D_Register;

architecture Behavioral of D_Register is
    signal register_data : STD_LOGIC_VECTOR(15 downto 0);

begin
    -- Processo para controle do registrador de 16 bits
    process(clk, reset)
    begin
        if (reset = '1') then   -- Reseta o registrador quando o sinal de reset é '1'
            register_data <= (others => '0');
        elsif (rising_edge(clk)) then  -- Detecta a borda de subida do sinal de clock
            for i in 0 to 15 loop
                if (enable(i) = '1') then  -- Verifica o sinal de habilitação para cada flip-flop
                    register_data(i) <= d(i); -- Carrega o dado na entrada do flip-flop
                end if;
            end loop;
        end if;
    end process;

    -- Saída do registrador
    q <= register_data;

end Behavioral;
                  
