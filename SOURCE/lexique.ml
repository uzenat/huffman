open Treehuff;;

(* Structure du lexique *)
type lexique = Vlex | Nlex of (int*int list) * lexique * lexique;;

(* ajoute un element au lexique *)
let rec add_lex lex elem = match lex with
  | Vlex -> Nlex(elem,Vlex,Vlex)
  | Nlex( (c,bin), g, d) ->
    if (fst elem) = c then Nlex((c,bin),g,d)
    else if (fst elem)<c then Nlex((c,bin),add_lex g elem,d)
    else Nlex((c,bin),g,add_lex d elem);;

(* recupere un element du lexique *)
let rec get_lex lex chr = match lex with
  | Vlex -> failwith "chr n'est pas contenue dans le lexique"
  | Nlex( (c,bin), g, d) ->
    if chr = c then bin
    else if chr < c then get_lex g chr
    else get_lex d chr;;

(* construit le lexique à partir de l'arbre de huffman *)
let rec build_lex tree_huff bin lex = match tree_huff with
  | Leaf(p,c) -> add_lex lex (c,bin)
  | Node(x,g,d) ->
    let lex = build_lex g (bin@[0]) lex in
    build_lex d (bin@[1]) lex;;

