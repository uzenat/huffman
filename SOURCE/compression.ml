open Histogramme;;
open Treehuff;;
open Lexique;;
open Tasmin;;
open Bitio;;

(* construction de l'arbre de huffman a partir d'un tas*)
let rec build_tree_huff tas = match tas with
  | Vide -> raise Tasmin.Empty_heap
  | Noeud(x,Vide,Vide) -> x
  | Noeud(_,f1,f2) ->
    let tree1 = prem tas in
    let t = suppr_prem tas in
    let tree2 = prem t in
    let t = suppr_prem t in
    let tree3 = Node( (poid tree1)+(poid tree2), tree1, tree2) in
    let t = add_tas t tree3 in
    build_tree_huff t;;
    

(*  retourne l'arbre de huffman et le lexique *)
let recup_outil file_in = 
  let h= build_histo file_in in
  let tas= build_tas h Vide in
  let tree_huff= build_tree_huff tas in
  let lex = build_lex tree_huff [] Vlex in
  tree_huff, lex;;
  

(* ecrit les 4 octets magiques *)
let write_magic_byte file_out =
  output_bit_byte file_out 135;
  output_bit_byte file_out 74;
  output_bit_byte file_out 31;
  output_bit_byte file_out 72;;

(* ecrit n octets *)
let rec write_n_byte file_out byte n = match byte with
  | [] -> ()
  | t::q -> 
    output_bit_byte file_out t;
    write_n_byte file_out q n;;

(* ecrit l'arbre de huffman *)
let rec write_tree_huff tree_huff file_out = match tree_huff with
  | Leaf(p,c) -> (* si on tombe sur une feuille *)
    if c = 255 then
      begin (* on ecrit un 0, suivit de 8bits valant 1, suivit d'un 0 *)
	output_bit file_out 0;
	output_bit_byte file_out 255;
	output_bit file_out 0;
      end
    else if c = 256 then 
      begin (* on ecrit un 0, suivit de 8bits valants 1, suivit d'un 1 *)
	output_bit file_out 0;
	output_bit_byte file_out 255;
	output_bit file_out 1;
      end
    else 
      begin (* on ecrit un 0, suivit du code ascii du caractere *)
      	output_bit file_out 0;
	output_bit_byte file_out c;
      end
  | Node(p,g,d) -> (* si on tombe sur un noeud *)
    output_bit file_out 1; (* on ecrit un 1 *)
    write_tree_huff g file_out; (* on recurse sur le noeud gauche *)
    write_tree_huff d file_out;; (* on recurse sur le noeud droit *)

(* ecrit une liste de bit *)
let rec write_bit file_out bit = match bit with
  | [] -> failwith "liste vide"
  | [t] ->  output_bit file_out t
  | t::q -> output_bit file_out t; write_bit file_out q;;

(* codage du texte *)
let codage file_in file_out lex = 

  (* fonction interne qui retourne un type Some *)
  let input i = 
    try 
	let c= input_byte i in
	Some(c)
      with
	End_of_file -> None
  in

  (* fonction interne recursive terminale *)
  let rec codage' file_in file_out lex s = 
    match s with
    | None -> 
      seek_in file_in 0;
      let code= get_lex lex 256 in
      write_bit file_out code
    | Some(c) -> 
      write_bit file_out (get_lex lex c); 
      codage' file_in file_out lex (input file_in)
	
  in
  
  let c= input file_in in
  codage' file_in file_out lex c;; 

(* compression *)
let compression file_in file_out =
  let tuple = recup_outil file_in in
  let tree_huff= fst tuple in
  let lex = snd tuple in
  write_magic_byte file_out;
  output_bit_byte file_out 0;
  write_tree_huff tree_huff file_out;
  codage file_in file_out lex;
  output_align_bit file_out;
  output_bit_byte file_out 0;



