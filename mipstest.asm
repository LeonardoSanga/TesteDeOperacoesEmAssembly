# mipstest.asm
# Se as instruções estiverem corretas, esse código deve escrever o valor
# 16 no endereço 68
# Assembly 		Description		Address 	Machine
addi $2, $0, 7	       # inicializa $2 = 7 	400000 	       20020007
addi $3, $0, 9	       # inicializa $3 = 9 	400004	       20030009
add $4, $2, $3	       # $4 = 7 + 9 	        400008	       00432020
sw $4, 68($0)          # mem[68] = 16	        40000C 	       ac040044 





















