{
open Lexing
open Parser

exception SyntaxError of string

let next_line lexbuf =
  let pos = lexbuf.lex_curr_p in
  lexbuf.lex_curr_p <-
    { pos with pos_bol = lexbuf.lex_curr_pos;
               pos_lnum = pos.pos_lnum + 1
    }
}

let digit = ['0'-'9']
let number = '-'? digit digit*

let ws = [' ' '\t']+
let newline = '\r' | '\n' | "\r\n"

rule read = parse
  | ws { read lexbuf }
  | newline { next_line lexbuf; read lexbuf }
  | number { NUMBER (float_of_string (Lexing.lexeme lexbuf))}
  | "true" { BOOLEAN true }
  | "false" { BOOLEAN false }
  | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf))}
  | eof { EOF }