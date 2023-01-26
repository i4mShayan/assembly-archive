# selection sort
.data
array: .space 4000
next_line: .asciiz "\n"

.text
.globl main

main:
    li $v0, 5 # read n
    syscall
    move $s0, $v0 #s0 = n
    la $t0, array #index = 0
    sll $s7, $s0, 2 #s7 = n*4
    add $s7, $s7, $t0 #s7 = array + n*4 = array_end
    j get_array

end:
    li $v0, 10
    syscall # exit

get_array:
    beq $t0, $s7, selection_sort # if index == array_end
    li $v0, 5 # read array[index]
    syscall
    sw $v0, 0($t0) # array[index] = v0
    addi $t0, $t0, 4 # index++
    j get_array

selection_sort:
    la $t0, array #i = 0
    j outer_loop

outer_loop:
    addi $t5, $s7, -4 #t5 = array_end - 4
    beq $t0, $t5, print_array # if i == array_end - 4
    move $t1, $t0 #min_index = i
    addi $t3, $t0, 4 #j = i+1
    j inner_loop

inner_loop:
    beq $t3, $s7, finish_inner_loop # if j == n, finish inner loop
    lw $t4, 0($t1) #t4 = array[min_index]
    lw $t5, 0($t3) #t5 = array[j]
    bgt $t4, $t5, update_min_index # if array[min_index] > array[j], update min_index
    addi $t3, $t3, 4 #j++
    j inner_loop

finish_inner_loop:
    lw $t6, 0($t0) #t6 = array[i]
    lw $t7, 0($t1) #t7 = array[min_index]

    #swap array[i] and array[min_index]
    sw $t7, 0($t0) #array[i] = array[min_index]
    sw $t6, 0($t1) #array[min_index] = array[i]

    addi $t0, $t0, 4 #i++
    j outer_loop

update_min_index:
    move $t1, $t3 #min_index = j
    addi $t3, $t3, 4 #j++
    j inner_loop

print_array:
    la $t0, array #i = 0
    j print_array_loop

print_array_loop:
    beq $t0, $s7, end # if i == array_end, end
    lw $a0, 0($t0) #a0 = array[i]
    li $v0, 1 # print int
    syscall
    jal print_new_line
    addi $t0, $t0, 4 #i++
    j print_array_loop


print_new_line:
    la $a0, next_line
    li $v0, 4
    syscall
    jr $ra
