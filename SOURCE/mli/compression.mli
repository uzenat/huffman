(** @author Eric UZENAT & Mohamed YENNEK *)

(** construit l'arbre de huffman à partir d'un tas min *)
val build_tree_huff : Tasmin.tas_min -> Treehuff.tree_huff

(** retourne un tuple contenant l'arbre de huffman et le lexique *)
val recup_outil : in_channel -> Treehuff.tree_huff * Lexique.lexique

(** ecrit les octets magiques *)
val write_magic_byte : Bitio.bit_out_channel -> unit

(** ecrit n octet *)
val write_n_byte : Bitio.bit_out_channel -> int list -> 'a -> unit

(** ecrit l'arbre de huffman *)
val write_tree_huff : Treehuff.tree_huff -> Bitio.bit_out_channel -> unit

(** ecrit une liste de bit *)
val write_bit : Bitio.bit_out_channel -> int list -> unit

(** ecrit le codage *)
val codage : in_channel -> Bitio.bit_out_channel -> Lexique.lexique -> unit

(** methode prenant en argument un d'entree et un fichier de sortie 
    et compresse le fichier d'entrer vers le fichier de sortie en
    respectant le bon format *)
val compression : in_channel -> Bitio.bit_out_channel -> unit
