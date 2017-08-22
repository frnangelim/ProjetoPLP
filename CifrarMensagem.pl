?- use_module(library(random)).

/* Tabela default, pesquisa por linha */
linha(0,['Y','Q','D','L','G']).
linha(1,['M','J','X','F','U']).
linha(2,['V','W','C','P','B']).
linha(3,['O','S','K','R','E']).
linha(4,['T','H','N','A','I']).
/* Tabela default, pesquisa por coluna */
coluna(0,['Y','M','V','O','T']).
coluna(1,['Q','J','W','S','H']).
coluna(2,['D','X','C','K','N']).
coluna(3,['L','F','P','R','A']).
coluna(4,['G','U','B','E','I']).

/* Gerando uma Matriz Aleatoria*/
matrizAleatoria(matriz,[]).
matrizAleatoria(L,K) :- random_permutation(L,K). 

pertence(X,[X|_]).
pertence(X,[_|Y]):- pertence(X,Y).

/*Parametros: ELEMENTO,MATRIZ,INDICE,RESULTADO*/
encontraLinha(E,[H|_],I,I) :- pertence(E,H).
encontraLinha(E,[_|T],I,R) :- IX is I+1, encontraLinha(E,T,IX,R).
/*Parametros: ELEMENTO,LINHA DA MATRIZ,INDICE,RESULTADO*/
encontraColuna(E,[E|_],I,I).
encontraColuna(E,[_|T],I,R) :- IX is I+1, encontraColuna(E,T,IX,R).

estaNaMesmaLinha(E,E1) :- matriz(_,M), encontraLinha(E,M,0,I),encontraLinha(E1,M,0,I1), I = I1.
estaNaMesmaColuna(E,E1) :- matriz(_,M), encontraLinha(E,M,0,I),encontraLinha(E1,M,0,I1), 
							getByIndice(I,M,0,L1),getByIndice(I1,M,0,L2),
							encontraColuna(E,L1,0,J),encontraColuna(E1,L2,0,J1), J = J1.

letraDeBaixo(E,R) :- matriz(_,M),encontraLinha(E,M,0,I),getByIndice(I,M,0,L),encontraColuna(E,L,0,J),IX is mod(I+1,5), getByIndice(IX,M,0,LX), getByIndice(J,LX,0,R).
letraDaDireita(E,R) :- matriz(_,M),encontraLinha(E,M,0,I),getByIndice(I,M,0,L),encontraColuna(E,L,0,J),IJ is mod(J+1,5), getByIndice(IJ,L,0,R).

correspondente(E,E1,R,R1) :- matriz(_,M),encontraLinha(E,M,0,I),encontraLinha(E1,M,0,I1),
								getByIndice(I,M,0,L1),getByIndice(I1,M,0,L2),
								encontraColuna(E,L1,0,J1),encontraColuna(E1,L2,0,J2),
								getByIndice(J2,L1,0,R), getByIndice(J1,L2,0,R1).

getByIndice(I,[E|_],I, E).
getByIndice(I,[_|L],IA, R) :- getByIndice(I,L,IB,R), IA is IB-1.

cifraMensagem([],[]).
/*cifraMensagem([A:B:XS],R):- estaNaMesmaLinha(A,B), letraDaDireita(A,AD), letraDaDireita(B,BD), string_concat(B,D,R).*/


cabeca([Cabeca|_], Cabeca).
cauda([_|Cauda], Cauda).

colocaX(Lista, [], [Lista]).
colocaX(Lista, [Lista|Cauda], [Lista|['x'|S]]) :- colocaX(Lista,Cauda,S).
colocaX(Lista, [Cabeca|Cauda], [Lista|S]) :- colocaX(Cabeca,Cauda,S).


/*Funcaoo que retorna a matriz atual*/
retornaMatriz:-
	write("Matriz atual:"),nl,
	matriz(Matriz),
	escreveMatriz(Matriz),nl,nl,
	main.
	
	
escreveLinha([]).
escreveLinha([Cabeca|Cauda]) :- write(Cabeca), write(" "), 
					   escreveLinha(Cauda).


escreveMatriz([]). 
escreveMatriz([Cabeca|Cauda]) :- escreveLinha(Cabeca), 
						nl,
						escreveMatriz(Cauda).
						
/*Encerra a execucao*/				
encerra:-
	write("Fim da execução!"),nl,nl,halt(0).


matriz(_,[['Y','Q','D','L','G'],
		['M','J','X','F','U'], 
		['V','W','C','P','B'], 
		['O','S','K','R','E'], 
		['T','H','N','A','I']]).

execute(5) :- matriz(_,M), escreveMatriz(M).
execute(6) :- encerra.

:- initialization main.

main:-

	write("Digite o numero da opcao:"),nl,
	write("1. Escolher uma tabela de cifra nova"),nl,
	write("2. Introduzir uma mensagem para cifrar"),nl,
	write("3. Ver a mensagem cifrada"),nl,
	write("4. Decifrar mensagem"),nl,
	write("5. Ver o alfabeto" ),nl,
	write("6. Terminar\n" ),nl,
	
	read(L),
	execute(L).
