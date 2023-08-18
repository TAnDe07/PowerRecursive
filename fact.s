.section .data

input_prompt	:	.asciz	"Please enter a number: "
input_spec	:	.asciz	"%d"
result		:	.asciz	"factorial = %d\n"

.section .text

.global main

main:

# add code and other labels here
# print input prompt
  ldr x0, =input_prompt
  bl printf

# take input in
	sub sp, sp, #16
	ldr x0, =input_spec
	mov x1, sp
	bl scanf
afterscan:
# save value from stack
	ldr x19, [sp, #0]

# restore stack
	add sp, sp, #16

# move into argument
  mov x0, x19

# call recursive function
	bl fact

# print result
	ldr x0, =result
	bl printf

	b exit

fact:

        #if x0 <=1, return 1
        subs x10, x0, #1
        b.gt recursiveCase
        mov x1, #1
        br x30

recursiveCase:
	# 2 items on stack
	sub sp, sp, #16
	# save return address
	stur x30, [sp, #8]
	stur x0, [sp, #0]

	sub x0, x0, #1
        bl fact
        

	# pop 2
        ldr x30, [sp, #8]
        ldr x0, [sp, #0]

        mul x1, x1, x0
	add sp, sp, #16
	# return to caller
	br x30

# branch to this label on program completion
exit:
	mov x0, 0
	mov x8, 93
	svc 0
	ret