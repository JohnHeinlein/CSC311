//John Heinlein - Asgn04
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
enum Consts{BUFFER_SIZE = 4096};

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

    char* tmp = (char*)malloc(BUFFER_SIZE);
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
    //String delim is caught by strcpy, so we put it into a new string bounded by the terminal index to not waste space
    char* out = strcpy( (char*)malloc(sizeof(char)*tmpi), tmp);
    free(tmp);
    return out;
}
/*
struct Recip{
    char* Fullname;
    char* Firstname;
    char* Lastname;
    char* Address;
    char* Locale;
};
*/
enum Recip{fullname, firstname, lastname, address, locale};
void parsefiles(int arc, char *argv[]){
    FILE *out         = fopen(argv[0], "a+");
    FILE *letter      = fopen(argv[1], "r");
    FILE *recipients  = fopen(argv[2], "r");
    //struct Recip recipient;
    char** recip = malloc(BUFFER_SIZE * sizeof(char*));
    char* buff = (char*)malloc(sizeof(char)*BUFFER_SIZE);
    int i;

    while(fgets(buff, 80, recipients) != NULL){
        if(strcmp(buff, "\n") == 0) continue; //Skip blank line
        for(i = 0; i < 5; i++){
        	strcpy(recip[i], buff);
        	fgets(buff, 100, recipients);
        }fullname
		//Now we have a populated recipient struct
        /*
        strcpy(recip[fullname], buff);
        fgets(buff, 100, recipients);
        strcpy(recip[firstname], buff);
        fgets(buff, 100, recipients);
        strcpy(recip[lastname], buff);
        fgets(buff, 100, recipients);
        strcpy(recip[address], buff);
        fgets(buff, 100, recipients);
        strcpy(recip[locale], buff);
        */

        while(fgets(buff, 4096, letter) != NULL){
			//  #N# = full name of recipient
			//  #F# = First name of recipient
			//  #L# = Last name of recipient
			//  #A# = address of recipient
			buff = replaceAll(buff, "#N#", recip[fullname]);
			buff = replaceAll(buff, "#F#", recip[firstname]);
			buff = replaceAll(buff, "#L#", recip[lastname]);
			buff = replaceAll(buff, "#A#", recip[address]);
			printf("%s", buff);
        }
    }

    printf()

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
    /*
    if(argc != 3){
        printf("ERR: Incorrect number of arugments");
        exit(1);
    }
	*/
    parsefiles(argc, argv);


    char* src = "Lorem Ipsum Dolor Sit Amet";
    char* find = "o";
    char* replace = "FUCK";
    char* test = replaceAll(src, find, replace);
    printf("%s", test);
    return 0;
}