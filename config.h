/* file name	:	config.h
 * date			:	2019-07-31
 * author		:	gt
 * description	:	 
 * 
 * */

//与词法分析器接口
extern int yylineno ;	//来自于词法分析器
void yyerror(char *s,...) ;

struct Token ;
struct Right {
	int m_type ;
	union {
		struct Token *mr_reference ;
		char *mr_chars ;
		int mr_int ;
		double mr_double ;
	};
} ;

struct Token {
	char *m_left ;
	struct Right *m_right ;
} ;

int addToken(char *left , struct Right *right) ;
void displayTokens();


int OpenconfigFile(char *fn) ; 
