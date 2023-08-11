【1】测试编译器对RVV汇编指令的支持
这里用了一个rvv_lib.s作为示范
rvv_lib.s 包含了常用的几个函数作为示范v_memcpy, v_strcpy, v_strncpy, set_vtype, get_vtype
rvv_lib.s 你也可以尝试增加一些需要测试vector向量汇编

//编译
export PATH=/opt/gcc10.2/native/bin:$PATH
gcc -march=rv64gcv0p7_zfh_xtheadc -mabi=lp64d -mtune=c920  -c rvv_lib.s -o rvv_lib.o
gcc main.c  rvv_lib.o -o test


【2】测试编译器对于intrinsics的支持
 这里用intrinsic_test.c 作为示范
 里面使用了  vint32m2_t vadd_vv_i32m2 (vint32m2_t op1, vint32m2_t op2, size_tvl) 作为示范
 
 // 编译
export PATH=/opt/gcc10.2/native/bin:$PATH 
gcc -march=rv64gcv0p7_zfh_xtheadc -mabi=lp64d -mtune=c920 intrinsic_test.c -o intrinsic_test

