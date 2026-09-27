library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Eightbit_FullAdder is
    Port (
        A    : in  STD_LOGIC_VECTOR(7 downto 0);
        B    : in  STD_LOGIC_VECTOR(7 downto 0);
        Cin  : in  STD_LOGIC;
        Sum  : out STD_LOGIC_VECTOR(7 downto 0);
        Cout : out STD_LOGIC
    );
end Eightbit_FullAdder;

architecture DataFlow of Eightbit_FullAdder is

    signal C : STD_LOGIC_VECTOR(8 downto 0);

begin

    -- Initial carry
    C(0) <= Cin;

    -- Bit 0
    Sum(0) <= A(0) XOR B(0) XOR C(0);
    C(1) <= (A(0) AND B(0)) OR
            (A(0) AND C(0)) OR
            (B(0) AND C(0));

    -- Bit 1
    Sum(1) <= A(1) XOR B(1) XOR C(1);
    C(2) <= (A(1) AND B(1)) OR
            (A(1) AND C(1)) OR
            (B(1) AND C(1));

    -- Bit 2
    Sum(2) <= A(2) XOR B(2) XOR C(2);
    C(3) <= (A(2) AND B(2)) OR
            (A(2) AND C(2)) OR
            (B(2) AND C(2));

    -- Bit 3
    Sum(3) <= A(3) XOR B(3) XOR C(3);
    C(4) <= (A(3) AND B(3)) OR
            (A(3) AND C(3)) OR
            (B(3) AND C(3));

    -- Bit 4
    Sum(4) <= A(4) XOR B(4) XOR C(4);
    C(5) <= (A(4) AND B(4)) OR
            (A(4) AND C(4)) OR
            (B(4) AND C(4));

    -- Bit 5
    Sum(5) <= A(5) XOR B(5) XOR C(5);
    C(6) <= (A(5) AND B(5)) OR
            (A(5) AND C(5)) OR
            (B(5) AND C(5));

    -- Bit 6
    Sum(6) <= A(6) XOR B(6) XOR C(6);
    C(7) <= (A(6) AND B(6)) OR
            (A(6) AND C(6)) OR
            (B(6) AND C(6));

    -- Bit 7
    Sum(7) <= A(7) XOR B(7) XOR C(7);
    C(8) <= (A(7) AND B(7)) OR
            (A(7) AND C(7)) OR
            (B(7) AND C(7));

    -- Final carry
    Cout <= C(8);

end DataFlow;