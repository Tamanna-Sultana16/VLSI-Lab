LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Eightbit_FullAdder_TB IS
END Eightbit_FullAdder_TB;

ARCHITECTURE behavior OF Eightbit_FullAdder_TB IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT Eightbit_FullAdder
    PORT(
        A    : IN  STD_LOGIC_VECTOR(7 downto 0);
        B    : IN  STD_LOGIC_VECTOR(7 downto 0);
        Cin  : IN  STD_LOGIC;
        Sum  : OUT STD_LOGIC_VECTOR(7 downto 0);
        Cout : OUT STD_LOGIC
    );
    END COMPONENT;

    -- Input signals
    signal A   : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal B   : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal Cin : STD_LOGIC := '0';

    -- Output signals
    signal Sum  : STD_LOGIC_VECTOR(7 downto 0);
    signal Cout : STD_LOGIC;

    constant clock_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: Eightbit_FullAdder PORT MAP (
        A    => A,
        B    => B,
        Cin  => Cin,
        Sum  => Sum,
        Cout => Cout
    );

    -- Stimulus process
    stim_proc: process
    begin

        -- Test 1
        A <= "00000000";
        B <= "00000000";
        Cin <= '0';
        wait for clock_period;

        -- Test 2: 5 + 3 = 8
        A <= "00000101";
        B <= "00000011";
        Cin <= '0';
        wait for clock_period;

        -- Test 3: 15 + 1 = 16
        A <= "00001111";
        B <= "00000001";
        Cin <= '0';
        wait for clock_period;

        -- Test 4: 255 + 1 = 256
        A <= "11111111";
        B <= "00000001";
        Cin <= '0';
        wait for clock_period;

        -- Test 5: 100 + 50 = 150
        A <= "01100100";
        B <= "00110010";
        Cin <= '0';
        wait for clock_period;

        -- Test 6: 10 + 20 + Cin = 31
        A <= "00001010";
        B <= "00010100";
        Cin <= '1';
        wait for clock_period;

        -- Test 7: 255 + 255 = 510
        A <= "11111111";
        B <= "11111111";
        Cin <= '0';
        wait for clock_period;

        -- Test 8: 128 + 128 = 256
        A <= "10000000";
        B <= "10000000";
        Cin <= '0';
        wait for clock_period;

        wait;
    end process;

END;