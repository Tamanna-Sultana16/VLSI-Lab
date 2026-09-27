library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Eight_bit_reg is
    Port (
        D   : in  STD_LOGIC_VECTOR(7 downto 0);
        CLK : in  STD_LOGIC;
        Q   : out STD_LOGIC_VECTOR(7 downto 0)
    );
end Eight_bit_reg;

architecture DataFlow of Eight_bit_reg is

begin

    process(CLK)
    begin
        if rising_edge(CLK) then
            Q <= D;
        end if;
    end process;

end DataFlow;