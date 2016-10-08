(** @author Eric UZENAT & Mohamed YENNEK *)

(** structure de lexique *)
type lexique = Vlex | Nlex of (int * int list) * lexique * lexique

(** ajout d'une cle, valeur dans le lexique *)
val add_lex : lexique -> int * int list -> lexique

(** recupere la valeur pour une clé donné *)
val get_lex : lexique -> int -> int list

(** construit le lexique a partir de l'arbre de huffman *)
val build_lex : Treehuff.tree_huff -> int list -> lexique -> lexique
