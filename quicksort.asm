.data 
array: .word 1, 2, 3, 4, 5, -1, 6, 7
#array: .word 0,1,2,3,4,5,6,7,8,9

.text


#parameters
la a0, array
li a1, 0
li a2, 7

quicksort:
addi sp, sp ,-20
sw ra, 0(sp)
sw s0, 4(sp)
sw s1 , 8(sp)
sw s2, 12 (sp)
sw s3, 16(sp)



#we check if the condition is not verified we terminate the function 
bge a1, a2, if_condition2

#we save the parameters 
mv s0, a0
mv s1, a1
mv s2, a2


jal ra, partion
#the return resulted is in a0

mv s3, a0 #s1=p



mv a0,s0
mv a1, s1 #lo
addi a2, s3, -1 # p-1
jal ra, quicksort


mv a0, s0
addi a1, s3, 1 #P+1
mv a2, s2
jal ra quicksort


if_condition2:
end:
lw ra, 0(sp)
lw s0, 4(sp)
lw s1, 8(sp)
lw s2, 12(sp)
lw s3, 16(sp)
addi sp, sp, 20
ret
endquicksort:
nop







#we declare function partition:  the argument  s1=A   a1=lo   a2=hi 
partion: 
# i used in this function s1, s2, s4, s5
addi sp, sp, -16
sw s1, 0(sp)
sw s2, 4(sp)
sw s4, 8(sp)
sw s5, 12(sp)

mv s1, a0

#we choose the pivot as the last element in the array pivot=A[hi]
 slli t1, a2, 2
 add t1, s1, t1 #to find the postion of the pivot the ram
 
 lw s2, 0(t1) # now s2=pivot
 
 addi t1, a1, -1 #i=lo-1
 
#we declare the loop 

mv t2, a1 #j=lo
addi t3, a2, 0 # j'=hi-1 to compare the variable 
loop:
beq t2, t3 , end_loop #we compare j and hi-1

# we compute A[j] we put the offset in t4
slli t4, t2, 2
add t4, s1, t4
lw t5, 0(t4)
# now we check if the condition is false we go to the label
bgt s2, t5, not_if_condition

addi t1, t1, 1 #i=i+1

# we swap the values of A[i] and A[j]

      # we already have in t5==A[j] and the offset of A[j] is in t4
            
     # we compute A[i]
     slli t6, t1, 2
     add t6, s1, t6
     lw s4, 0(t6) 
     # now we store in the ram 
     sw t5, 0(t6) #we put A[j] in offset of A[i}
     sw s4, 0(t4) #we put A[i] in offset of A[j}

not_if_condition:
addi t2, t2,1 #j=j+1

j loop

end_loop :

# now we do the swap A[i+1] with A[hi]


     # we compute A[i]  #we already have the offset of A[i] in t6
     addi t1, t1, 1 #i=i+1
     slli t6,t1,2
     add t6,s1,t6
     lw s4, 0(t6)
     # we compute A[hi]
     slli t4, a2, 2
     add t4, s1, t4 #offset of A[hi]
     lw s5, 0(t4) 
     # now we store in the ram 
     sw s5, 0(t6) #we put A[hi] in offset of A[i+1}
     sw s4, 0(t4) #we put A[i+1] in offset of A[hi}
     
     
# we put the return value i+1 in a0     
addi a0, t1, 0

end_partion:

lw s1, 0(sp)
lw s2, 4(sp)
lw s4, 8(sp)
lw s5, 12(sp)
addi sp, sp , 16
jr ra

finish:

