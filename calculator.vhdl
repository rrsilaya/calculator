library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity calculator is
  port (
    clock     : out STD_LOGIC;
    stage     : out STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
    flag      : out STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    pc        : out STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    registers : out STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    instruction : out STD_LOGIC_VECTOR(20 downto 0)
  );
end entity;

architecture bev of calculator is
  -- Data Types
  type INSTRUCTIONS is array(14 downto 0) of STD_LOGIC_VECTOR(20 downto 0);

  -- Signals
  --signal instr_cache : INSTRUCTIONS;

  begin
    process
      FILE content       : TEXT;
      CONSTANT filename  : STRING := "input/1.txt";
      VARIABLE buff      : LINE;
      VARIABLE ins       : INTEGER := 0;
      VARIABLE clk       : INTEGER := 0;

      VARIABLE instr_cache : INSTRUCTIONS;
      VARIABLE fetched   : STD_LOGIC_VECTOR(14 downto 0) := (others => '0');
      VARIABLE decoded   : STD_LOGIC_VECTOR(14 downto 0) := (others => '0');
      VARIABLE executed  : STD_LOGIC_VECTOR(14 downto 0) := (others => '0');

      VARIABLE decoder   : INTEGER := 0;
      VARIABLE progCt    : INTEGER := 0;

      CONSTANT FETCH     : INTEGER := 5;
      CONSTANT DECODE    : INTEGER := 4;
      CONSTANT EXECUTE   : INTEGER := 3;
      CONSTANT MEMORY    : INTEGER := 2;
      CONSTANT WRITEBACK : INTEGER := 1;

      VARIABLE opcode    : STD_LOGIC_VECTOR(20 downto 0);
    begin
      -- [ File Reading ]
        file_open(content, filename, READ_MODE);

        while not endfile(content) loop
          readline(content, buff);
          read(buff, opcode);

          instr_cache(ins) := opcode;

          ins := ins + 1;
        end loop;

        file_close(content);

        while ins /= 15 loop
          instr_cache(ins) := std_logic_vector(to_unsigned(0, 21));
          ins := ins + 1;
        end loop;
      -- [/ File Reading ]

      for clk in 0 to 14 loop
        clock <= '1';

        -- Decode
        if fetched(decoder) = '1' then
          stage(DECODE) <= '1';
          decoder := decoder + 1;
        end if;

        -- Fetch
        if to_integer(unsigned(instr_cache(progCt)(2 downto 0))) /= 0 then
          if to_integer(unsigned(instr_cache(progCt)(8 downto 3))) /= 0 then
            stage(FETCH) <= '1';
            fetched(progCt) := '1';
          end if;
        end if;

        -- Program Counter
        instruction <= instr_cache(progCt);
        progCt := progCt + 1;
        pc <= std_logic_vector(to_unsigned(progCt, 4));

        wait for 1 ns;

        -- Reset Skip
        clock <= '0';
        instruction <= std_logic_vector(to_unsigned(0, 21));
        stage <= std_logic_vector(to_unsigned(0, 6));
        pc <= std_logic_vector(to_unsigned(0, 4));
        flag <= std_logic_vector(to_unsigned(0, 3));

        wait for 1 ns;
      end loop;
      wait;
  end process;
end bev;