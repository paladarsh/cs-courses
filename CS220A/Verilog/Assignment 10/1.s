.data
array: .space 48
msg: .asciiz "Enter a Number: "
msga: .asciiz "Enter elements of array:"
msgs: .asciiz "Enter search element: "
mss: .asciiz "Element Found at index:"
msn: .asciiz "Element Not Found"


.text
.globl main
main:
# Enter a number
li $v0, 4
la $a0, msg
syscall
# s0 has n
li $v0, 5
syscall
move $s0, $v0

# Enter elements of a
li $v0, 4
la $a0, msga
syscall

# s1 has address of a
la $s1, array
addi $t0, $0, 0
loop:
slt $t2, $t0, $s0
# s0 has n
beq $t2, 0, exitloop
li $v0, 5
syscall
sw $v0, 0($s1)
addi $s1, $s1,4
addi $t0, $t0,1
j loop
exitloop:

# Enter search element
li $v0, 4
la $a0, msgs
syscall

# s1 has k
li $v0, 5
syscall
move $s1, $v0

# arraypointer,beg,end,search
# a0, a1, a2, a3
la $a0, array
addi $a1, $0, 0
addi $a2, $s0, -1 
addi $a3, $s1, 0

addi $sp, $sp, -4
sw $ra,0($sp)

jal bsearch

lw $ra,0($sp)
addi $sp, $sp, 4

jr $ra

bsearch:
# if a2<a1 or end<beg
slt $t0, $a2, $a1
beq $t0, 0, nonret
# Print Not found
li $v0, 4
la $a0, msn
syscall
jr $ra

# else
nonret:
addi $sp, $sp, -4
sw $ra, 0($sp)
# t0 is mid
add $t0, $a1, $a2
srl $t0, $t0,1

# t1 has address of a[mid]
sll $t1,$t0,2
add $t1,$a0,$t1
# t2 has middle element
lw $t2,0($t1)
# if middle element!=search
bne $t2,$a3,lessormore
# Element Found
li $v0, 4
la $a0, mss
syscall

li $v0, 1
add $a0, $t0, $0
syscall
jr $ra

lessormore:
# t2<a3 or middle element<k
slt $t3, $t2, $a3
bne $t3, $0, more
addi $a2, $t0, -1
jal bsearch
j final
# k is more
more:
addi $a1, $t0, 1
jal bsearch
final:
lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra