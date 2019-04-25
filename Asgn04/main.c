//John Heinlein - Asgn04
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
enum Consts{BUFF_SMALL = 128, BUFF_LARGE = 4096};

//[output file] [letter text] [Recipients]

//[letter text]
//  #N# = full name of recipient
//  #A# = address of recipient
//  #F# = First name of recipient
//  #L# = Last name of recipient
//  Delimiters can appear any number of times in letter

//Replace all occurences of "find" in "src" with "replace"
//While this has thriply nested for loops, they are bounded by the size of the find and replace strings
char* replaceAll(char* src, char* find, char* replace){
    int srci=0,tmpi=0; //src index, tmp index
    int cursor;  //Cursor walks thru src to compare it to the find string

    char* tmp = (char*)malloc(BUFF_LARGE);
    for(; src[srci] != '\0' ; srci++){

    	//At every character, check to see if it equals the corresponding character in the find string.
        for(cursor = srci;  ((cursor - srci) < strlen(find)) && (src[cursor] == find[cursor - srci]); cursor++);

        //If it was equal the whole way through, we've found a matching substring
        if((cursor - srci) == strlen(find)){
        	//Read the replace string into the output string, advance ONLY output index
            for(cursor = 0; cursor < strlen(replace); cursor++, tmpi++) tmp[tmpi] = replace[cursor];
            //Skip the rest of the find string in the src string
            srci += (strlen(find) - 1);
        //If it wasn't equal, continue as normal
        }else tmp[tmpi++]=src[srci];
    }
    //After the replacements, add the strig delim to the end
    tmp[tmpi]='\0';
    src = strcpy(src, tmp);
    free(tmp);
}

void parsefiles(char* argv[]){
    FILE *out         = fopen(argv[1], "a+");
	FILE *letter      = fopen(argv[2], "r");
	FILE *recipients  = fopen(argv[3], "r");
	/*
	remove("out"); 								//debug
    FILE *out 		= fopen("out", "a+");		//
    FILE *letter 	= fopen("letter", "r");		//
    FILE *recipients = fopen("recipients", "r");//
	/**/

    char recip[5][BUFF_SMALL];
    char delims[4][4] = {"#N#","#F#","#L#","#A#"};

    char* buff  = (char*)malloc(sizeof(char)*BUFF_LARGE);
    char* buff2 = (char*)malloc(sizeof(char)*BUFF_LARGE);

    int i;
    int len;

    //Reads through each recipient entry
    while(fgets(buff, BUFF_SMALL, recipients) != NULL){
    	//Evaluate recipient
        for(i = 0; i < 5; i++){				//Iterate through recipient entry
        	strcpy(recip[i], buff);			//Store value in corresponding section of recipient array
        	len = (int)strlen(recip[i]);	//Store length of string
        	if (recip[i][len-1] == '\n')
        		recip[i][len-1] = '\0';		//Replace newline with string delim
        	fgets(buff, BUFF_SMALL, recipients);
        }

        //Substitute delimiters
        while(fgets(buff2, 2048, letter) != NULL){	//Iterate over every ling of letter
        	for(i = 0; i < 4; i++) 	//For each recipient value:
        		replaceAll(buff2, delims[i], recip[i]); //Parse the current line and replace delimiters
			//printf("||\t%s", buff2); //debug
			fprintf(out, "%s", buff2);
        }
        fprintf(out, "\n");
		rewind(letter); //Reset letter for next recipient
    }
    //Don't destroy the system (thanks, C):
	free(buff);
    free(buff2);

    fclose(out);
    fclose(letter);
    fclose(recipients);
}

int main(int argc, char *argv[]) {
    //[output file] [letter text] [names, addresses]

    //[text file]
    //  #N# = full name of recipient
    //  #A# = Address of recipient
    //  #F# = First name of recipient
    //  #L# = Last name of recipient
    //  Delimiters can appear any number of times in letter

    ///*
    if(argc != 4){
        printf("ERR: Incorrect number of arugments: %d\n", argc);
        exit(1);
    }
	/**/
    parsefiles(argv);

    return 0;
}