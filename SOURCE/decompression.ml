open Treehuff;;
open Bitio;;

(* Module traitant la decompression d'un fichier au format .hf *)


(* teste les octets magic *)
let rec is_magic_byte file_in =
  try 
    let m1= input_bit_byte file_in in
    let m2= input_bit_byte file_in in
    let m3= input_bit_byte file_in in
    let m4= input_bit_byte file_in in
    if (m1=135)&&(m2=74)&&(m3=31)&&(m4=72) then true
    else false
  with End_of_file -> false;;

(* ignore n octets *)
let ignore_n_byte file_in n =
  let rec ignore_n_byte' file_in n a =
  if n=0 then ()
  else ignore_n_byte' file_in (n-1) (input_bit_byte file_in)
  in
  ignore_n_byte' file_in n 0 ;;

(* decode arbre *)
let rec decode_tree_huff file_in = 
  let bit= input_bit file_in in	
  if bit= 1 then 
    let gauche= decode_tree_huff file_in in
    let droite= decode_tree_huff file_in in
    Node(0,gauche, droite)
  else
    let o= input_bit_byte file_in in
    if o=255 then
      let bit=input_bit file_in in
      if bit=0 then Leaf(0,255)
      else Leaf(0,256)
    else Leaf(0,o);;

(* decodage final *)
let rec decode tree_huff file_in file_out root = match tree_huff with 
  | Leaf(_,c) -> 
    if c <> 256 then
      begin
	output_byte file_out c ;
	decode root file_in file_out root
      end
  | Node(_,g,d) ->
    let bit= input_bit file_in in
    if bit=0 then (decode g file_in file_out root)
    else (decode d file_in file_out root);;


(* methode de decompression *)
let decompression file_in file_out =
  if is_magic_byte file_in then
    begin
      let o1= input_bit_byte file_in in
      ignore_n_byte file_in o1;
      let tree_huff= decode_tree_huff file_in in
      decode tree_huff file_in file_out tree_huff;
      ignore_n_byte file_in (input_bit_byte file_in);
    end
  else failwith "erreur: fichier .hf non valide";;
