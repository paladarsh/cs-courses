.data
comma: .asciiz ", "
msg: .asciiz "Enter a Number: "

.text
.globl main
main:
li $v0, 4
la $a0, msg
syscall
li $v0, 5
syscall
move $s0, $v0
addi $sp, -4
sw $ra, 0($sp)

li $s1, 0
loop:
bgt $s1,$s0 outs
move $a0, $s1
jal fibonacci
move $a0, $v0
li $v0, 1
syscall
li $v0, 4
la $a0, comma
syscall
addi $s1, $s1, 1
j loop
outs:
lw $ra, 0($sp)
addi $sp, 4
jr $ra

fibonacci:
li $t0, 0
beq $a0, $t0, Lab
li $t0, 1
beq $a0, $t0, Labs
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $a0, 0($sp)
addi $a0, $a0, -1
jal fibonacci

lw $a0, 0($sp)
addi $sp, $sp,-4
sw $v0, 0($sp)

addi $a0, $a0, -2
jal fibonacci
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