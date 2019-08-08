/* file name    :   config.y
 * date         :   2019-07-31
 * author       :   gt
 * description  :    
 * 
 * */

%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "config.h"


	struct Token *globalTokenTable[1024] = {0};
	int tokenIndex = -1 ;
	int addToken(char *left , struct Right *right) {
		struct Token *t = malloc(sizeof(struct Token)) ;
		t->m_left = left ;
		t->m_right = right ;
		globalTokenTable[++tokenIndex] = t ;
		return tokenIndex ;
	}
	void displayTokens() {
		struct Token **p ;
		int i ;
		p = globalTokenTable ;
		printf("No.,key=:value,type\n") ;
		for (i = 0 ; i <= tokenIndex ; i++) {
			switch((*p)->m_right->m_type) {
				case 'C' : {
					printf("%d,%s=:%s,%c\n",p-globalTokenTable,(*p)->m_left,(*p)->m_right->mr_chars,(*p)->m_right->m_type) ;	
					break ;
				}
				case 'I' : {
					printf("%d,%s=:%d,%c\n",p-globalTokenTable,(*p)->m_left,(*p)->m_right->mr_int,(*p)->m_right->m_type) ;	
					break ;
				}
				case 'F' : {
					printf("%d,%s=:%f,%c\n",p-globalTokenTable,(*p)->m_left,(*p)->m_right->mr_double,(*p)->m_right->m_type) ;	
					break ;
				}
				default : {
					printf("Right type error \n") ;
					break ;
				}
			}
			p++ ;
		}
	}

%}

%union {
	struct Right *r ;
	char *l ;
	int value_int ;
	double value_double ;
	char *value_chars ;
}

%token <value_int> INTEGER
%token <value_double> DOUBLE
%token <value_chars> CHARS
%token EOL

%type <l> left
%type <r> right

%%

config : line config            {
								}
	| 							{
									printf("读取配置文件完成！\n"); ;
								}
	;

line : left operate right EOL 	{
							   		addToken($1,$3) ;
								}
	;

left : CHARS               		{
							   		int len = strlen($1) ;
									char *temp = malloc(sizeof(len+1)) ;
									memcpy(temp,$1,len+1) ;
									$$ = temp ;
						   		}
	;

operate : '='					{
								}
	;

right : CHARS               	{
							    	int len = strlen($1) ;
								    char *temp_chars = malloc(sizeof(len+1)) ;
								    memcpy(temp_chars,$1,len+1) ;
									struct Right *temp = malloc(sizeof(struct Right)) ;
									temp->m_type = 'C' ;
									temp->mr_chars = temp_chars ;
									$$ = temp ;
								}
	| INTEGER               	{
									struct Right *temp = malloc(sizeof(struct Right)) ;
									temp->m_type = 'I' ;
									temp->mr_int = $1 ; 
									$$ = temp ;
								}
	| DOUBLE                	{
									struct Right *temp = malloc(sizeof(struct Right)) ;
									temp->m_type = 'F' ;
									temp->mr_double = $1 ; 
									$$ = temp ;
								}
	| '$' CHARS             	{
									printf("还没有支持引用类型变量 '$' CHARS reduce right \n") ;
									//  $$ = newNode('R',) ;
								}
	;


%%
