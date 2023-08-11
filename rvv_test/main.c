#include <stdio.h>
#include <string.h>
#include <time.h>
#include <stdint.h>
#include <stdlib.h>

#include "rvv_lib.h"


int main(){
	char a[] = "i'm A,123456\r\n";
	char b[100];
	
	printf("hello~ perfxlab~\r\n");

	//测试rvv_lib
	printf("v_strcpy\r\n");
	v_strcpy(b,a);
	printf(b);
	
	//测试intintrinsics
	

	
}




