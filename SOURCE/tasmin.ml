open Treehuff;;

(* Module de Tas binaire minimum *)

(* structure du tas min *)
type tas_min = Vide | Noeud of tree_huff * tas_min * tas_min;; 

exception Empty_heap;;

(* renvoie le premier element du tas min *)
let prem tas= match tas with
  | Vide -> raise Empty_heap
  | Noeud(x,g,d) -> x;;

(* supprime le premier element du tas min *)
let rec suppr_prem tas = match tas with
  | Vide -> Vide
  | Noeud(x,Vide,Vide) -> Vide
  | Noeud(x,g,Vide) -> Noeud(prem g, suppr_prem g, Vide)
  | Noeud(x,Vide,d) -> Noeud(prem d, Vide, suppr_prem d)
  | Noeud(x,g,d) -> 
    if (poid (prem g)) < (poid (prem d)) then Noeud(prem g, suppr_prem g, d)
    else Noeud(prem d, g, suppr_prem d);; 

(* ajoute un element au tas min *)
let rec add_tas tas elem = match tas with
  | Vide -> Noeud(elem, Vide, Vide)
  | Noeud(x,g,d) -> Noeud( (minn x elem), d, add_tas g (maxx x elem));;

(* construit le tas min à partir d'une liste de tuple (char*int) *)
let rec build_tas l tas= match l with
  | [] -> tas
  | (c,p)::q -> 
    let tas= add_tas tas (Leaf(p,c)) in
    build_tas q tas;;
