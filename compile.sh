# Usage:
# $ chmod +x compile.sh
# $ ./compile.sh hello_world
# 
# NOTE: No need to include .vhdl extension.

ghdl -a $1.vhdl
ghdl -e $1
./$1
