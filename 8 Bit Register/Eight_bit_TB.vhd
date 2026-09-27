LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Eight_bit_TB IS 
END Eight_bit_TB; 
  
ARCHITECTURE behavior OF Eight_bit_TB IS  

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT Eight_bit_reg 
    PORT( 
         D   : IN  std_logic_vector(7 downto 0); 
         CLK : IN  std_logic; 
         Q   : OUT std_logic_vector(7 downto 0)
        ); 
    END COMPONENT; 
    
    -- Inputs
    signal D   : std_logic_vector(7 downto 0) := (others => '0'); 
    signal CLK : std_logic := '0'; 

    -- Outputs
    signal Q   : std_logic_vector(7 downto 0); 

    -- Clock period
    constant CLK_period : time := 10 ns; 
  
BEGIN 
  
    -- Instantiate the Unit Under Test (UUT)
    uut: Eight_bit_reg PORT MAP ( 
          D   => D, 
          CLK => CLK, 
          Q   => Q
        ); 

    -- Clock generation process
    CLK_process : process
    begin
        CLK <= '0';
        wait for CLK_period/2;
        
        CLK <= '1';
        wait for CLK_period/2;
    end process;


    -- Stimulus process
    stim_proc: process
    begin

        -- Initial value
        D <= "00000000";
        wait for 20 ns;

        -- Test 1
        D <= "10101010";
        wait for 20 ns;

        -- Test 2
        D <= "11110000";
        wait for 20 ns;

        -- Test 3
        D <= "00001111";
        wait for 20 ns;

        -- Test 4
        D <= "11001100";
        wait for 20 ns;

        -- Test 5
        D <= "00110011";
        wait for 20 ns;

        -- Test 6
        D <= "11111111";
        wait for 20 ns;

        -- Test 7
        D <= "00000000";
        wait for 20 ns;

        -- Stop simulation
        wait;

    end process; 

END behavior;