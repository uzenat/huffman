EXECUTABLE=huffman

HTML="<html><title>DOCUMENTATION PROJET 2014</title><body><center><h1> Codage de Huffman - Documentation </h1></center><center><a href='SOURCE/doc/index.html'> Acceder a la doc </a></center></body></html>"

$(EXECUTABLE):
	@ (cd SOURCE && make huffman)
	@ mv SOURCE/huffman . 

doc:
	@ (cd SOURCE && make dochtml)
	@ (echo  $(HTML) > doc.html)

clean:
	@ (cd SOURCE && make clean)
	@ rm -f doc.html
	@ rm -f huffman
