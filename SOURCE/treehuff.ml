
(* Structure de l'arbre de huffman *)
type tree_huff= Leaf of (int*int) | Node of int * tree_huff * tree_huff;;

(* recupere le poid d'un noeud de l'arbre *)
let poid tree_huff = match tree_huff with
  | Leaf(p,c) -> p
  | Node(p,g,d) -> p;;

(* renvoie le minimum de deux arbre *)
let minn x y = 
  if (poid x)<(poid y) then x else y;;

(* renvoie le maximum de deux arbre *)
let maxx x y = 
  if (poid x)>=(poid y) then x else y;;
