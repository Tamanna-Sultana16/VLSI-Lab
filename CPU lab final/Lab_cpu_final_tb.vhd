--------------------------------------------------------------------------------
-- Lab_cpu_final_tb.vhd
-- Testbench for Mini 8-bit Accumulator CPU (Set 9)
-- Student ID: 22201059
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Lab_cpu_final_tb is
end Lab_cpu_final_tb;

architecture behavior of Lab_cpu_final_tb is

    component Lab_cpu_final
        port (
            clk    : in  std_logic;
            reset  : in  std_logic;
            q      : out std_logic_vector(7 downto 0);
            z      : out std_logic;
            pc_out : out std_logic_vector(3 downto 0)
        );
    end component;

    signal clk    : std_logic := '0';
    signal reset  : std_logic := '0';
    signal q      : std_logic_vector(7 downto 0);
    signal z      : std_logic;
    signal pc_out : std_logic_vector(3 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    DUT : Lab_cpu_final
        port map (
            clk    => clk,
            reset  => reset,
            q      => q,
            z      => z,
            pc_out => pc_out
        );

    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    stim_proc : process
    begin
        reset <= '1';
        wait for CLK_PERIOD;
        reset <= '0';

        for i in 1 to 12 loop
            wait for CLK_PERIOD;
        end loop;

        assert false report "Simulation finished successfully." severity note;
        wait;
    end process;

end behavior;