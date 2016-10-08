MLI=bitio.mli histogramme.mli treehuff.mli tasmin.mli lexique.mli compression.mli decompression.mli main.mli
CMI=$(MLI:.mli=.cmi)

FLAGS=-g
CAMLC=ocamlc $(FLAGS)
CAMLOPT=ocamlopt $(FLAGS)

all:
	@ ($(CAMLOPT) $(MLI))
	@ (cp $(CMI) .. && cp $(MLI) ..)

clean:
	@ rm -f *~
	@ rm -f *.cmi
