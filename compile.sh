# Usage:
# $ chmod +x compile.sh
# $ ./compile.sh hello_world
# 
# NOTE: No need to include .vhdl extension.

ghdl -a --ieee=synopsys $1.vhdl
ghdl -e --ieee=synopsys $1
./$1
