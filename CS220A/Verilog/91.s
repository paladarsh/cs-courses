.text
.globl main

main:
li $v0, 5
syscall
move $a0, $v0
addi $sp, -4
sw $ra, 0($sp)
jal factorial

move $a0, $v0
li $v0, 1
syscall

lw $ra, 0($sp)
addi $sp, 4
jr $ra


factorial:
li $t0, 0
beq $a0, $t0, Lab
li $t0, 1
beq $a0, $t0, Labs
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $a0, 0($sp)
addi $a0, $a0, -1
jal factorial

lw $a0, 0($sp)
addi $sp, $sp,-4
sw $v0, 0($sp)

addi $a0, $a0, -2
jal factorial
lw $t0, 0($sp)
add $v0, $t0, $v0

lw $ra, 8($sp)
addi $sp, $sp, 12
jr $ra

Lab:
li $v0, 0
jr $ra
Labs:
li $v0, 1
jr $ra