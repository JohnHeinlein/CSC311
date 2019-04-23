#include <stdio.h>
#include <string.h>

int main(){
	//Input value, loop index
	int iInt, i;

	//Continue prompt, input/output bases, binary conversion buffer
	char sentinel, iBase, oBase, str[32];

	do{
		do{//Input sanitation
			sentinel = 0;

			printf("Base of input integer: b = binary, d = decimal, h = hex, o = octal\n>> ");
			scanf(" %c", &iBase);

			if(iBase != 'b' && iBase != 'd' &&
			   iBase != 'h' && iBase !=  'o'){
				sentinel = 1;
				printf("Please enter one of the suggested symbols\n");
			}
		}while(sentinel);

		printf("Enter the number: ");
		if(iBase == 'b'){
			scanf(" %s", str);

			for(i = 0, iInt = 0; i < strlen(str); i++)
				iInt  = iInt * 2 + (str[i] - 48);
		}else{
			scanf(" %i", &iInt);
		}

		do{//Input sanitation
			sentinel = 0;
			printf("Enter the base of the output (d, h, or o): ");
			scanf(" %c", &oBase);

			if(oBase != 'd' && oBase != 'h' && oBase != 'o'){
				sentinel = 1;
				printf("Please enter one of the suggested symbols\n");
			}
		}while(sentinel);

		printf("The integer ");
		switch (iBase){
			case 'd': printf("%d in decimal ", iInt);	break;
			case 'h': printf("%x in hexadecimal ", iInt);	break;
			case 'o': printf("%o in octal ", iInt);		break;
			case 'b': printf("%s in binary ", str);		break;
		}

		printf("is ");
		switch (oBase){
			case 'd': printf("%d in decimal ", iInt); 	break;
			case 'h': printf("%x in hexadecimal ", iInt); 	break;
			case 'o': printf("%o in octal ", iInt); 	break;
		}

		printf("\nContinue? (Y or N) ");
		scanf(" %c", &sentinel);
	}while(sentinel * sentinel - 188*sentinel + 8580);
	//Who needs reader-friendly char comparisons when you can
	//solve a quadratic for their ASCII values?
	return 0;
}
