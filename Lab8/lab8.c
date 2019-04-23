#include <stdio.h>
#include <stdlib.h>
void q(int question){printf("\n%d)\n",question);}
int main(){
		q(1);
		int i1 = 1, i2 = 2;
		double d1 = 1.1, d2 = 2.2;
		printf("&i1: 0x%p\t\t&i2: 0x%p\n&d1: 0x%p\t\t&d2: 0x%p\n", 
			    &i1, &i2, &d1, &d2);
		
		q(2);
		int 	*intptr1;	int 	*intptr2;
		double 	*dubptr1;	double 	*dubptr2;
		printf("&intptr1: 0x%p\t&intptr2: 0x%p\n&dubptr1: 0x%p\t&dubptr2: 0x%p\n", 
				&intptr1, &intptr2, &dubptr1, &dubptr2);
		
		q(3);
		intptr1 = &i1;	intptr2 = &i2;
		dubptr1 = &d1; 	dubptr2 = &d2;
		printf("intptr1: %p\t\tintptr2: %p\ndubptr1: %p\tdubptr2: %p\n", 
				intptr1, intptr2,dubptr1, dubptr2);
		
		q(4);
		intptr1 = intptr2;
		printf("intptr1: %p\n", intptr1);
		dubptr1 = intptr1;
		printf("dubptr1: %p\n", dubptr1);
		dubptr1 = (double *)intptr1;
		printf("dubptr1: %p\n", dubptr1);
		
		q(5);
		intptr1 = NULL;
		printf("intptr1: %p\n", intptr1);
		
		q(6);
		printf("*intptr2: %d\n", *intptr2);
		//printf("*intptr1: %d\n", *intptr1); //Segfault
		
		q(7);
		*intptr2 = 100;
		printf("i1: %d\ti2: %d\n", i1, i2);
		
		q(8);
		printf("(intptr2 + 1): %p\t*(intptr2 + 1): %d\n", (intptr2 + 1), *(intptr2 + 1));
		printf("(intptr2 - 1): %p\t*(intptr2 - 1): %d\n", (intptr2 - 1), *(intptr2 - 1));
		printf("(dubptr2 + 1): %p\t*(dubptr1 + 1): %f\n", (dubptr2 + 1), *(dubptr2 + 1));
		printf("(dubptr2 - 1): %p\t*(dubptr2 - 1): %f\n", (dubptr2 - 1), *(dubptr2 - 1));
		
		q(9);
		printf("intptr1 = &i1\n");	intptr1 = &i1;
		printf("\t intptr1 ==  intptr2: %d\n", intptr1 == intptr2);
		printf("\t*intptr1 == *intptr2: %d\n", *intptr1 == *intptr2);
		printf("intptr1 = &it2\n"); intptr1 = &i2;
		printf("\t intptr1 ==  intptr2: %d\n", intptr1 == intptr2);
		printf("\t*intptr1 == *intptr2: %d\n", *intptr1 == *intptr2);
		
		q(10);
		double *ptr = malloc(sizeof (double));
		*ptr = 3.1416;
		printf("Value of ptr: %p\tValue of *ptr: %f\n", ptr, *ptr);
		
		q(11);
		free((void *) ptr);
		ptr = malloc(sizeof (double));
		printf("Value of ptr: %p\tValue of *ptr: %f\n", ptr, *ptr);
}
