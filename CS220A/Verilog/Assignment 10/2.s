.data
arraya: .space 60
msg: .asciiz "Enter a Number: "
msga: .asciiz "Enter elements of array:"

.text
.globl main
main:
li $v0, 4
la $a0, msg
syscall

li $v0, 5
syscall
move $s0, $v0
# s0 has n

la $t0, arraya
li $t1, 0
# t0 has address of a(0)
li $v0, 4
la $a0, msga
syscall

loopa:
bge $t1,$s0, out
li $v0, 6
syscall
swc1 $f0, 0($t0)
addi $t0, $t0, 4
addi $t1, $t1, 1
j loopa

out:
mtc1 $0, $f12
la $t0, arraya
li $t1, 0
li $t2, 0

# t0 has address of a(0)
loops:
bge $t1, $s0, term
lwc1 $f1, 0($t0)
bne $t2, $0, subt
li $t2,1
add.s $f12,$f12, $f1
j final
subt:
li $t2,0
sub.s $f12,$f12, $f1
final:
addi $t0,$t0, 4
addi $t1,$t1, 1
j loops

term:
li $v0, 2
syscall
jr $ra