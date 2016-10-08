(** @author Eric UZENAT & Mohamed YENNEK *)

(** structure de l'histogramme *)
type histo = Vhisto | Nhisto of (int * int) * histo * histo

(** ajoute un élément dans l'histogramme *)
val add_histo : histo -> int -> histo

(** transforme un histogramme en list *)
val histo_to_list : histo -> (int * int) list

(** construit l'histogramme *)
val build_histo : in_channel -> (int * int) list
