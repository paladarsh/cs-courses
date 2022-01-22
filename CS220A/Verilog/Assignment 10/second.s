.data
arraya: .space 60
arrayb: .space 60
msg: .asciiz "Enter a Number: "
msga: .asciiz "Enter elements of arraya:"
msgb: .asciiz "Enter elements of arrayb:"

.text
.globl main
main:
li $v0, 4
la $a0, msg
syscall

li $v0, 5
syscall
move $s0, $v0 #s0 has n

la $t0, arraya
addi $t1, $s0, -1
sll $t1, $t1, 2
add $t0, $t0, $t1
addi $t1, $s0, -1

li $v0, 4
la $a0, msga
syscall

loopa:
bltz $t1, jb
li $v0, 6
syscall
swc1 $f0, 0($t0)
addi $t0, $t0, -4
addi $t1, $t1, -1
j loopa



jb:
la $t0, arrayb
addi $t1, $s0, -1
sll $t1, $t1, 2
add $t0, $t0, $t1
addi $t1, $s0, -1

li $v0, 4
la $a0, msgb
syscall

loopb:
bltz $t1, out
li $v0, 6
syscall
swc1 $f0, 0($t0)
addi $t0, $t0, -4
addi $t1, $t1, -1
j loopb

out:
mtc1 $0, $f12
addi $t1, $0, 0
la $t2, arraya
la $t3, arrayb

loop:
slt $t4, $t1, $s0
beq $t4, 0, term
lwc1 $f1, 0($t2)
lwc1 $f2, 0($t3)
mul.s $f1,$f1,$f2
add.s $f12,$f12,$f1
addi $t2, $t2, 4
addi $t3, $t3, 4
addi $t1, $t1, 1
j loop

term:
li $v0, 2
syscall
jr $ra