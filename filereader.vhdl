library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity filereader is
  port(
    opcode  :  in std_logic_vector(20 downto 0);
    dataout : out std_logic_vector(20 downto 0)
  );
end entity;

architecture bev of filereader is
  type processor is array(255 downto 0) of std_logic_vector(20 downto 0);
  signal processor_t : processor;

  begin
    process
      FILE     f         : text;
      CONSTANT filename  : string := "input/1";
      VARIABLE line_read : line;
      VARIABLE i         : integer := 0;
      VARIABLE buff      : std_logic_vector(20 downto 0);

    begin
      File_Open(f, FILENAME, read_mode);
      while (not EndFile(f)) loop
        readline(f, line_read);
        read(line_read, buff);

        dataout <= buff;
        processor_t(i) <= buff;
        wait for 20 ns;
        
        i := i + 1;
      end loop;
      File_Close(f);
      wait;
  end process;
end bev;

--filereading reference: https://www.edaplayground.com/x/3vh
