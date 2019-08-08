%option noyywrap nodefault yylineno

%{
#include <stdio.h>
#include <string.h> 
#include "config.h"
#include "config.bison.tab.h"
%}

EXP ([Ee][-+]?[0-9]+)

%%
[a-zA-Z_][a-zA-Z_0-9]*		{
								yylval.value_chars = yytext ; 
								return CHARS ;
							}
"$"|"="						{return yytext[0];}

[+-]?([1-9][0-9]*\.[0-9]+|[0]\.[0-9]+)	{
								yylval.value_double = atof(yytext);
								return DOUBLE ;
							}

[+-]?([1-9][0-9]*|[0])		{
								yylval.value_int = atoi(yytext) ;
								return INTEGER ;
							}

^\n							{/*忽略空行*/}
\n							{return EOL ;}
#[^\n]*\n					{/*忽略注释*/}
[ \t]						{/*忽略空白符*/}
.							{yyerror("Mystery character %c\n",*yytext) ;}
%%

int OpenconfigFile(char *fn) {
	FILE *f = fopen(fn,"r") ;
	if (!f) {
		perror(fn) ;
		return 0 ;
	}
	YY_BUFFER_STATE bs = yy_create_buffer(f,YY_BUF_SIZE) ;
	yy_switch_to_buffer(bs) ;
	yyparse() ;
	yy_delete_buffer(bs) ;
	return 1 ;
}
