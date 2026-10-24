--------------------------------------------------------------------------------
-- Lab_cpu_final.vhd
-- Mini 8-bit Accumulator CPU  (Dataflow Architecture)
-- Student ID: 22201059  |  Set 9
-- Instructions: LDI, ADD, NOT, SHL, JZ
-- Course: CSE 450 (VLSI Lab) - Final Project, Spring 2026
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Lab_cpu_final is
    port (
        clk    : in  std_logic;
        reset  : in  std_logic;
        q      : out std_logic_vector(7 downto 0);  -- ACC output
        z      : out std_logic;                     -- Z flag
        pc_out : out std_logic_vector(3 downto 0)   -- PC (for checking)
    );
end Lab_cpu_final;

architecture dataflow of Lab_cpu_final is

    -- ============================================================
    -- Program ROM : 16 x 12-bit constant array (Set 9 program)
    -- ============================================================
    type rom_array is array (0 to 15) of std_logic_vector(11 downto 0);

    constant ROM : rom_array := (
        0  => x"13F",  -- LDI 0x3F
        1  => x"700",  -- NOT
        2  => x"C05",  -- JZ 0x05
        3  => x"211",  -- ADD 0x11
        4  => x"800",  -- SHL
        5  => x"C00",  -- JZ 0x00
        6  => x"800",  -- SHL
        7  => x"000",  -- NOP
        8  => x"000",
        9  => x"000",
        10 => x"000",
        11 => x"000",
        12 => x"000",
        13 => x"000",
        14 => x"000",
        15 => x"000"
    );

    -- ============================================================
    -- Internal signals
    -- ============================================================
    signal pc_reg    : std_logic_vector(3 downto 0) := (others => '0');
    signal instr     : std_logic_vector(11 downto 0);
    signal opcode    : std_logic_vector(11 downto 8);
    signal operand   : std_logic_vector(7 downto 0);

    signal acc_reg   : std_logic_vector(7 downto 0) := (others => '0');
    signal z_reg     : std_logic := '1';

    signal alu_sel   : std_logic_vector(2 downto 0);
    signal alu_result: std_logic_vector(7 downto 0);
    signal zero_flag : std_logic;

    signal acc_ld    : std_logic;
    signal z_ld      : std_logic;
    signal pc_ld     : std_logic;
    signal pc_inc    : std_logic;

begin

    -- 1. Program ROM (combinational)
    instr  <= ROM(to_integer(unsigned(pc_reg)));
    opcode <= instr(11 downto 8);
    operand<= instr(7 downto 0);

    -- 2. ALU (combinational, selected assignment)
    with alu_sel select
        alu_result <= operand                    when "000",
                      std_logic_vector(unsigned(acc_reg) + unsigned(operand))
                                                             when "001",
                      not acc_reg                when "010",
                      std_logic_vector(unsigned(acc_reg) sll 1)
                                                             when "011",
                      acc_reg                    when others;

    zero_flag <= '1' when alu_result = x"00" else '0';

    -- 3. Control Unit (combinational)
    process(opcode, zero_flag)
    begin
        alu_sel <= "000";
        acc_ld  <= '0';
        z_ld    <= '0';
        pc_ld   <= '0';
        pc_inc  <= '1';

        case opcode is
            when "0001" =>          -- LDI
                alu_sel <= "000";
                acc_ld  <= '1';
                z_ld    <= '1';
            when "0010" =>          -- ADD
                alu_sel <= "001";
                acc_ld  <= '1';
                z_ld    <= '1';
            when "0111" =>          -- NOT
                alu_sel <= "010";
                acc_ld  <= '1';
                z_ld    <= '1';
            when "1000" =>          -- SHL
                alu_sel <= "011";
                acc_ld  <= '1';
                z_ld    <= '1';
            when "1100" =>          -- JZ
                if zero_flag = '1' then
                    pc_ld  <= '1';
                    pc_inc <= '0';
                else
                    pc_ld  <= '0';
                    pc_inc <= '1';
                end if;
            when others =>          -- NOP
                pc_inc <= '1';
        end case;
    end process;

    -- 4. PC (sequential)
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                pc_reg <= (others => '0');
            elsif pc_ld = '1' then
                pc_reg <= operand(3 downto 0);
            elsif pc_inc = '1' then
                pc_reg <= std_logic_vector(unsigned(pc_reg) + 1);
            end if;
        end if;
    end process;

    -- 5. ACC (sequential)
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                acc_reg <= (others => '0');
            elsif acc_ld = '1' then
                acc_reg <= alu_result;
            end if;
        end if;
    end process;

    -- 6. Z flag (sequential)
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                z_reg <= '1';
            elsif z_ld = '1' then
                z_reg <= zero_flag;
            end if;
        end if;
    end process;

    -- 7. Outputs
    q      <= acc_reg;
    z      <= z_reg;
    pc_out <= pc_reg;

end dataflow;