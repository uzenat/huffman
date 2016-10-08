(** @author Eric UZENAT & Mohamed YENNEK *)

(** structure de l'arbre de huffman *)
type tree_huff = Leaf of (int * int) | Node of int * tree_huff * tree_huff

(** retourne le poid de la racine de l'arbre *)
val poid : tree_huff -> int

(** retourne le tree huff de poid minimum *)
val minn : tree_huff -> tree_huff -> tree_huff

(** retourne le tree huff de poid maximum *)
val maxx : tree_huff -> tree_huff -> tree_huff
