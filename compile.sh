# Usage:
# $ chmod +x compile.sh
# $ ./compile.sh hello_world
# 
# NOTE: No need to include .vhdl extension.

ghdl -a --ieee=synopsys $1.vhdl
ghdl -e --ieee=synopsys $1
ghdl -r --ieee=synopsys $1 --vcd=$1.vcd
