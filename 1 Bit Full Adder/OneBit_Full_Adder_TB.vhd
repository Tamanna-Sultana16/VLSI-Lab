LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY OneBit_Full_Adder_TB IS
END OneBit_Full_Adder_TB;

ARCHITECTURE behavior OF OneBit_Full_Adder_TB IS

    -- Component Declaration
    COMPONENT OneBit_Full_Adder
    PORT(
        A    : IN  STD_LOGIC;
        B    : IN  STD_LOGIC;
        Cin  : IN  STD_LOGIC;
        Sum  : OUT STD_LOGIC;
        Cout : OUT STD_LOGIC
    );
    END COMPONENT;

    -- Inputs
    signal A   : STD_LOGIC := '0';
    signal B   : STD_LOGIC := '0';
    signal Cin : STD_LOGIC := '0';

    -- Outputs
    signal Sum  : STD_LOGIC;
    signal Cout : STD_LOGIC;

    -- Time period
    constant clock_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test
    uut: OneBit_Full_Adder
    PORT MAP (
        A    => A,
        B    => B,
        Cin  => Cin,
        Sum  => Sum,
        Cout => Cout
    );

    -- Stimulus process
    stim_proc: process
    begin

        -- 000
        A <= '0';
        B <= '0';
        Cin <= '0';
        wait for clock_period;

        -- 001
        A <= '0';
        B <= '0';
        Cin <= '1';
        wait for clock_period;

        -- 010
        A <= '0';
        B <= '1';
        Cin <= '0';
        wait for clock_period;

        -- 011
        A <= '0';
        B <= '1';
        Cin <= '1';
        wait for clock_period;

        -- 100
        A <= '1';
        B <= '0';
        Cin <= '0';
        wait for clock_period;

        -- 101
        A <= '1';
        B <= '0';
        Cin <= '1';
        wait for clock_period;

        -- 110
        A <= '1';
        B <= '1';
        Cin <= '0';
        wait for clock_period;

        -- 111
        A <= '1';
        B <= '1';
        Cin <= '1';
        wait for clock_period;

        -- Stop simulation
        wait;

    end process;

END behavior;