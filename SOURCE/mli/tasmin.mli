(** @author Eric UZENAT & Mohamed YENNEK *)


(** structure de tas min *)
type tas_min = Vide | Noeud of Treehuff.tree_huff * tas_min * tas_min

(** Exception si le tas est vide *)
exception Empty_heap

(** retourne la racine d'un tas min *)
val prem : tas_min -> Treehuff.tree_huff

(** supprime la racine du tas *)
val suppr_prem : tas_min -> tas_min

(** ajout d'un élément dans le tas *)
val add_tas : tas_min -> Treehuff.tree_huff -> tas_min

(** construit le tas à partir d'une liste de char * int *)
val build_tas : (int * int) list -> tas_min -> tas_min
