(** @author Eric UZENAT & Mohamed YENNEK *)


(** test si les 4 premier octets du fichier sont les bits magiques *)
val is_magic_byte : Bitio.bit_in_channel -> bool

(** ignore n octet *)
val ignore_n_byte : Bitio.bit_in_channel -> int -> unit

(** decode l'arbre de huffman *)
val decode_tree_huff : Bitio.bit_in_channel -> Treehuff.tree_huff

(** decode la suite de bits correspondant au codage de huffman et ecrit le
    decodage dans le fichier de sortie *)
val decode :
  Treehuff.tree_huff ->
  Bitio.bit_in_channel -> out_channel -> Treehuff.tree_huff -> unit

(** methode prenant en argument un fichier d'entree et un fichier de sortie
    et ecrit le decodage du fichier d'entree dans le fichier de sortie *)
val decompression : Bitio.bit_in_channel -> out_channel -> unit
