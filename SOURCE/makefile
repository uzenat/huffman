SOURCES=bitio.ml histogramme.ml treehuff.ml tasmin.ml lexique.ml compression.ml decompression.ml main.ml
OBJECTS=$(SOURCES:.ml=.cmx)
INTERFACES=$(SOURCES:.ml=.mli)
FLAGS=-g
PP=
EXECUTABLE=huffman

CAMLC=ocamlc $(FLAGS)
CAMLOPT=ocamlopt $(FLAGS)
CAMLDOC=ocamldoc 
CAMLDEP=ocamldep


$(EXECUTABLE): $(OBJECTS)
	@ $(CAMLOPT) -o $(EXECUTABLE) $(OBJECTS)

$(OBJECTS): $(SOURCES)
	@ $(CAMLOPT) -c $(SOURCES)

$(SOURCES): 
	@ (cd mli && make all)

dochtml:
	@ (cd mli && make all)		
	@ $(CAMLDOC) -m A -d doc -html $(INTERFACES)

clean:
	@ (cd mli && make clean)
	@ rm -f *.cm[ioxa]
	@ rm -f *.o
	@ rm -f *.mli
	@ rm -f doc/*.html
	@ rm -f doc/*.css
	@ rm -f doc/*.3o
	@ rm -f *~
