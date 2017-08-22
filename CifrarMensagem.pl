?- use_module(library(random)).

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

cifraMensagem([], '').
cifraMensagem([A,B|C],R):- estaNaMesmaLinha(A,B), letraDaDireita(A,AD), letraDaDireita(B,BD), string_concat(AD,BD,X), cifraMensagem(C, R1), string_concat(X,R1, R2), R = R2.
cifraMensagem([A,B|C],R):- estaNaMesmaColuna(A,B),letraDeBaixo(A,AB), letraDeBaixo(B,BB), string_concat(AB,BB,X), cifraMensagem(C, R1), string_concat(X,R1, R2), R = R2.
cifraMensagem([A,B|C],R):- correspondente(A,B,AC,BC), string_concat(AC,BC,X), cifraMensagem(C, R1), string_concat(X,R1, R2), R = R2.

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
	write("Fim da execucao!"),nl,nl,halt(0).


matriz(_,[['Y','Q','D','L','G'],
		['M','J','X','F','U'], 
		['V','W','C','P','B'], 
		['O','S','K','R','E'], 
		['T','H','N','A','I']]).

execute(1) :- read(X),write(X),main. /* Preparar e cifrar mensagem */
execute(2) :- matriz(_,M), escreveMatriz(M),main.
execute(3) :- matriz(_,M), matrizAleatoria(M,M1), escreveMatriz(M1),main.
execute(4) :- encerra,main.

:- initialization main.

main:-
	write("Digite o numero da opcao:"),nl,
	write("1. Introduzir uma mensagem para cifrar"),nl,
	write("2. Ver o alfabeto"),nl,
	write("3. Escolher uma tabela de cifra nova"),nl,
	write("4. Terminar\n" ),nl,
	
	read(L),
	execute(L).
