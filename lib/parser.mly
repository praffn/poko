%token EOF
%token <float> NUMBER
%token <bool> BOOLEAN

%start <Ast.expr option> prog
%%

prog:
  | EOF { None }
  | e = expr { Some e }
  ;

expr:
  | n = NUMBER { Number n }
  | b = BOOLEAN { Boolean b }
