library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity filereader is
  port(
    operator : out std_logic_vector(2 downto 0);
    operand1 : out std_logic_vector(5 downto 0);
    operand2 : out std_logic_vector(5 downto 0);
    operand3 : out std_logic_vector(5 downto 0)
  );
end entity;

architecture bev of filereader is
  type processor_operator is array(255 downto 0) of std_logic_vector(2 downto 0);
  type processor_operand1 is array(255 downto 0) of std_logic_vector(5 downto 0);
  type processor_operand2 is array(255 downto 0) of std_logic_vector(5 downto 0);
  type processor_operand3 is array(255 downto 0) of std_logic_vector(5 downto 0);
  signal processor_o : processor_operator;
  signal processor_o1 : processor_operand1;
  signal processor_o2 : processor_operand2;
  signal processor_o3 : processor_operand3;

  begin
    process
      FILE     f         : text;
      CONSTANT filename  : string := "input/1";
      VARIABLE line_read : line;
      VARIABLE i         : integer := 0;
      VARIABLE counter_op1: integer := 1;
      VARIABLE counter_op2: integer := 1;
      VARIABLE counter_op3: integer := 1;

      VARIABLE operator_value  : std_logic_vector(2 downto 0);
      VARIABLE operand1_value  : std_logic_vector(5 downto 0);
      VARIABLE operand2_value  : std_logic_vector(5 downto 0);
      VARIABLE operand3_value  : std_logic_vector(5 downto 0);
    begin
      File_Open(f, FILENAME, read_mode);
      while (not EndFile(f)) loop
        readline(f, line_read);
        read(line_read, operator_value);
        read(line_read, operand1_value);
        read(line_read, operand2_value);
        read(line_read, operand3_value);
        
        operator <= operator_value;
        processor_o(i) <= operator_value;
        i := i + 1;
       
        operand1 <= operand1_value;
        processor_o1(counter_op1) <= operand1_value;
        counter_op1 := counter_op1 + 1;
       
        operand2 <= operand2_value;
        processor_o2(counter_op2) <= operand2_value;
        counter_op2 := counter_op2 + 1;
       
        operand3 <= operand3_value;
        processor_o3(counter_op3) <= operand3_value;
        counter_op3 := counter_op3 + 1;
       
        wait for 20 ns;

      end loop;
      File_Close(f);
      wait;
  end process;
end bev;

--filereading reference: https://www.edaplayground.com/x/3vh
