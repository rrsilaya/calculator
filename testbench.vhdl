library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity calc_tb is
  constant DELAY         : time    := 20 ns;
  constant OPERATOR_SIZE : integer := 2;
  constant OPERAND_SIZE  : integer := 5;
end entity calc_tb;

architecture testbench of calc_tb is
  signal operator : std_logic_vector(OPERATOR_SIZE downto 0);
  signal operand1 : std_logic_vector(OPERAND_SIZE downto 0);
  signal operand2 : std_logic_vector(OPERAND_SIZE downto 0);
  signal operand3 : std_logic_vector(OPERAND_SIZE downto 0);

  component calculator is
    port (
      operand : 
    );
  end component calculator;
end architecture testbench;