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

  begin process(opcode)
    FILE     f         : text;
    CONSTANT filename  : string := "input/2";
    VARIABLE line_read : line;
    VARIABLE i         : integer := 0;
    VARIABLE buff      : std_logic_vector(20 downto 0);

    begin
      File_Open(f, FILENAME, read_mode);
      while (not EndFile(f)) loop
        readline(f, line_read);
        read(line_read, buff);

        processor_t(i) <= buff;
        for count in 0 to 20 loop
          report std_logic'image(buff(20 - count));
        end loop;
        report "\n";
        
        i := i + 1;
      end loop;
      File_Close(f);

      --dataout <= processor_t(opcode);
  end process;
end bev;

--filereading reference: https://www.edaplayground.com/x/3vh
