.data
yes: .ASCIIZ "YES"
no: .ASCIIZ "NO"
.text
.globl main

main:
    li $v0, 5 # read n
    syscall
    move $s0, $v0 #s0 = n
    li $t0, 1 #t0 = 1
    li $s1, 0 #s1 = 0 (sum)
    j loop
end:
    li $v0, 10
    syscall # exit

after_loop:
    li $v0, 4 # print string
    beq $s0, $s1, print_yes # if n == sum
    la $a0, no # print NO
    syscall
    j end

print_yes:
    la $a0, yes
    syscall #print YES
    j end

loop:
    bge $t0, $s0, after_loop # break if t0 >= n
    div $s0, $t0
    mfhi $t1 # t1 = n % t0
    bne $t1, $zero, continue # if n % t0 != 0, continue
    add $s1, $s1, $t0 # sum += t0
    addi $t0, $t0, 1 # t0++
    j loop

continue:
    addi $t0, $t0, 1 # t0++
    j loop
