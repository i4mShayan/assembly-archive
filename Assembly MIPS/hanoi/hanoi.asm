.data
arrow: .asciiz "->"
newline: .asciiz "\n"

.text
.globl main


main:
    li $v0, 5
    syscall # read n
    move $a0, $v0 # a0 = n
    li $a1, 'A' # from
    li $a2, 'C' # to
    li $a3, 'B' # help

    jal hanoi

    li $v0, 10
    syscall

hanoi:
    bne $a0, 0, hanoi_block # if n != 0
    jr $ra

hanoi_block:
    addi $sp, $sp, -20 # reserve space for 5 registers

    sw $ra, 0($sp) # save ra
    sw $a0, 4($sp) # save a0
    sw $a1, 8($sp) # save a1
    sw $a2, 12($sp) # save a2
    sw $a3, 16($sp) # save a3

    lw $a2, 16($sp) # to -> help
    lw $a3, 12($sp) # help -> to

    addi $a0, $a0, -1 # n - 1

    jal hanoi

    lw $ra, 0($sp) # restore ra
    lw $a0, 4($sp) # restore a0
    lw $a1, 8($sp) # restore a1
    lw $a2, 12($sp) # restore a2
    lw $a3, 16($sp) # restore a3

    jal print

    lw $a1, 16($sp) # from -> help
    lw $a2, 12($sp) # to -> to
    lw $a3, 8($sp) # help -> from

    addi $a0, $a0, -1 # n - 1

    jal hanoi

    lw $ra, 0($sp) # restore ra

    addi $sp, $sp, 20 # free space for 5 registers

    jr $ra



print:
    move $t9, $a0 # saving a0 in temporary register

    move $a0, $a1 
    li $v0, 11
    syscall # print a1

    la $a0, arrow
    li $v0, 4
    syscall # print arrow

    move $a0, $a2
    li $v0, 11
    syscall # print a2

    la $a0, newline
    li $v0, 4
    syscall # print newline

    move $a0, $t9 # restoring a0
    jr $ra
