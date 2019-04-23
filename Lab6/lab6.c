#include <stdio.h>

int main(){
	int x, y, z;
	printf("Enter int 1: ");
	scanf("%d", &x);
	printf("Enter int 2: ");
	scanf("%d", &y);
	printf("Enter int 3: ");
	scanf("%d", &z);
	
	printf("%d times %d minus %d is %d\n", x, y, z, (x*y) - z);
	
	printf("This is a C program\n");
	printf("This is\na C program\n");
	printf("This\nis\na\nC\nprogram\n");
	printf("This\tis\ta\tC\tprogram\n");
	
	int i,j;
	for(i=5; i>0; i--){
		for(j=i; j>0; j--) printf("*");
		printf("\n");
	}
	
	return 0;
}
