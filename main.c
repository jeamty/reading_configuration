#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "config.h"
#include "config.bison.tab.h"

void
yyerror(char *s,...) {
	va_list ap ;
	va_start(ap,s) ;

	fprintf(stderr,"%d: error: ",yylineno) ;
	vfprintf(stderr,s,ap) ;
	fprintf(stderr,"\n") ;	
}

int
main(int argc,char **argv) {
	if (argc != 2) {
		fprintf(stderr,"arguments error!\n") ;
		fprintf(stderr,"./config configuration_file_name \n") ;
		return -1 ;
	}
	printf("initial...\n ") ;
	OpenconfigFile(*(argv+1)) ;
	//OpenconfigFile(argv[1]) ;
	printf("configuration item info ..\n ") ;
	displayTokens() ;	
	return 0 ; 
}
