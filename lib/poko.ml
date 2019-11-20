let parse_program program =
  let lexbuf = Lexing.from_string program in
  try Parser.prog Lexer.read lexbuf with
  | Lexer.SyntaxError msg ->
    print_endline msg;
    None
  | Parser.Error ->
    print_endline "syntax error";
    exit(-1)