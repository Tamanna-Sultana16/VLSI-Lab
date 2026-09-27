library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OneBit_Full_Adder is
    Port (
        A    : in  STD_LOGIC;
        B    : in  STD_LOGIC;
        Cin  : in  STD_LOGIC;
        Sum  : out STD_LOGIC;
        Cout : out STD_LOGIC
    );
end OneBit_Full_Adder;

architecture DataFlow of OneBit_Full_Adder is

begin

    Sum <= A XOR B XOR Cin;

    Cout <= (A AND B) OR (B AND Cin) OR (A AND Cin);

end DataFlow;