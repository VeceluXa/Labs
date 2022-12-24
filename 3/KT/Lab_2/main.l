%option noyywrap
%{
int LineIndex = 1;
%}
%%
^(.|\n)	{	
		printf("%3d ",LineIndex);
		ECHO;
		LineIndex++;
	}
%%

int main()
{
	yylex();
}
