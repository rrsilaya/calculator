library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity calculator is
  port (
    clock : out STD_LOGIC;
    stage : out STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
    flag  : out STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    pc    : out STD_LOGIC_VECTOR(3 downto 0) := (others => '0')
  );
end entity;

architecture bev of calculator is
  -- Data Types
  type INSTRUCTIONS is array(14 downto 0) of STD_LOGIC_VECTOR(20 downto 0);

  -- Signals
  signal instr_cache : INSTRUCTIONS;

  begin
    process
      FILE content       : TEXT;
      CONSTANT filename  : STRING := "input/1.txt";
      VARIABLE buff      : LINE;
      VARIABLE i         : INTEGER := 0;
      VARIABLE clk       : INTEGER := 0;

      VARIABLE opcode    : STD_LOGIC_VECTOR(20 downto 0);
    begin
      -- [ File Reading ]
        file_open(content, filename, READ_MODE);

        while not endfile(content) loop
          readline(content, buff);
          read(buff, opcode);

          instr_cache(i) <= opcode;

          i := i + 1;
        end loop;

        file_close(content);
      -- [/ File Reading ]

      for clk in 0 to 20 loop
        -- Clock
        if (clk MOD 2) = 0 then clock <= '1';
        else                  clock <= '0';
        end if;

        -- Program Counter
        if (clk MOD 2) = 0 then pc <= std_logic_vector(to_unsigned((clk / 2) + 1, 4));
        else pc <= std_logic_vector(to_unsigned(0, 4));
        end if;

        wait for 20 ns;
      end loop;
      wait;
  end process;
end bev;