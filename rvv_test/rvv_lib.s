	.globl v_memcpy, v_strcpy, v_strncpy, set_vtype, get_vtype

	# void* v_memcpy(void* dest, const void* src, size_t n)
	# a0=dest, a1=src, a2=n
	#
v_memcpy:
	mv a3, a0 		# Copy destination
1:	vsetvli a4, a2, e8,m4	# Vectors of 8b
	vlbu.v v0, (a1)		# Load bytes
	add a1, a1, a4		# Bump pointer
	sub a2, a2, a4		# Decrement count
	vsb.v v0, (a3)		# Store bytes
	add a3, a3, a4		# Bump pointer
	bnez a2, 1b		# Any more?
	ret

	
	# char* v_strcpy(char *dst, const char* src)
v_strcpy:
	mv a2, a0		# Copy dst
1:	vsetvli x0, x0, e8,m4	# Vectors of bytes
	vlbuff.v v4, (a1)	# Get src bytes
	csrr t1, vl		# Get number of bytes fetched
	vmseq.vi v0, v4, 0	# Flag zero bytes
	vmfirst.m a3, v0	# Zero found?
	vmsif.m v0, v0		# Set mask up to and including zero byte.
	add a1, a1, t1		# Bump pointer
	vsb.v v4, (a2), v0.t	# Write out bytes
	add a2, a2, t1		# Bump pointer
	bltz a3, 1b		# Zero byte not found, so loop
	ret

	
	# char* v_strncpy(char *dst, const char* src, size_t n)
v_strncpy:
	mv a3, a0		# Copy dst
1:	vsetvli x0, a2, e8	# Vectors of bytes.
	vlbuff.v v1, (a1)	# Get src bytes
	vmseq.vi v0, v1, 0	# Flag zero bytes
	vmfirst.m a4, v0	# Zero found?
	vmsif.m v0, v0		# Set mask up to and including zero byte.
	vsb.v v1, (a3), v0.t	# Write out bytes
	bgez a4, 2f		# Done
	csrr t1, vl		# Get number of bytes fetched
	add a1, a1, t1		# Bump pointer
	sub a2, a2, t1		# Decrement count.
	add a3, a3, t1		# Bump pointer
	bnez a2, 1b		# Anymore?
2:	ret

	# long set_vtype(long vtype)
set_vtype:
	vsetvl x0,x0,a0
	csrr a0,vtype
	ret

	# long get_vtype()
get_vtype:
	csrr a0,vtype
	ret
	

