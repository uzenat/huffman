open Compression;;
open Decompression;;
open Bitio;;


(* test si un nom est d'extansion .hf *)
let isHF arg =
  let n= String.length arg in
  if n <= 3 then false
  else
    if arg.[n-1] <> 'f' then false
    else 
      if arg.[n-2] <> 'h' then false
      else 
	if arg.[n-3] <> '.' then false
	else true;;


(* PROGRAMME MAIN *)

let () =
  let arg= Sys.argv in
  if (Array.length arg != 4) || not((arg.(1) = "-c")||(arg.(1) = "-d")) then 
    let s= "usage: "^arg.(0)^": [-c ou -d] compress.hf fichier" in
    print_endline s;
  else
    if not (isHF arg.(2)) then 
      let s= "erreur: " ^ arg.(2) ^ " n'est pas d'extansion .hf" in
      print_endline s
    else
      begin
	try 
	  if arg.(1) = "-c" then
	    begin
	      let file_out= open_out_bit arg.(2) in
	      let file_in= open_in_bin arg.(3) in
	      compression file_in file_out;
	      print_endline "compression reussie !";
	      close_in file_in;
	      close_out_bit file_out;
	    end
	  else
	    begin
	      let file_out= open_out_bin arg.(3) in
	      let file_in= open_in_bit arg.(2) in
	      decompression file_in file_out;
	      print_endline "decompression reussie !";
	      close_in_bit file_in;
	      close_out file_out;
	    end
	with
	| Sys_error(s) -> print_endline (arg.(3)^" n'existe pas")
      end;;
