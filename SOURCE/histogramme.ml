
type histo = Vhisto | Nhisto of (int * int) * histo * histo ;;

let rec add_histo histo c = match histo with
  | Vhisto -> Nhisto ( (c,1), Vhisto, Vhisto )
  | Nhisto ( (u,v),g,d) -> 
    if u = c then Nhisto ((u,v+1), g, d)
    else if c < u then Nhisto( (u,v), add_histo g c, d)
    else Nhisto( (u,v), g, add_histo d c) ;;

let rec histo_to_list' h l ll = match h with
  | Vhisto -> 
    begin 
      match l with 
      | [] -> ll
      | (d::l') -> histo_to_list' d l' ll
    end
  | Nhisto (v,g,d) -> histo_to_list' g (d::l) (v::ll) ;;

let histo_to_list h = histo_to_list' h  [] [] ;;

let input_chr i = 
  try 
    Some(input_byte i)
  with
    End_of_file -> None ;;

let rec build_histo' h file_in s = match s with
  | None -> h
  | Some(c) -> build_histo' (add_histo h c) file_in (input_chr file_in) ;;
let build_histo file_in = 
  let h= build_histo' Vhisto file_in (input_chr file_in) in
  let h = add_histo h 256 in
  seek_in file_in 0 ;
  histo_to_list h ;;
