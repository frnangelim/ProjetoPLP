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

estaNaMesmaLinha(E,M,E1) :- encontraLinha(E,M,0,I),encontraLinha(E1,M,0,I1), I = I1.
estaNaMesmaColuna(E,M,E1) :- encontraLinha(E,M,0,I),encontraLinha(E1,M,0,I1), 
							getByIndice(I,M,0,L1),getByIndice(I1,M,0,L2),
							encontraColuna(E,L1,0,J),encontraColuna(E1,L2,0,J1), J = J1.

letraDeBaixo(E,M,R) :- encontraLinha(E,M,0,I),getByIndice(I,M,0,L),encontraColuna(E,L,0,J),IX is mod(I+1,5), getByIndice(IX,M,0,LX), getByIndice(J,LX,0,R).
letraDaDireita(E,M,R) :- encontraLinha(E,M,0,I),getByIndice(I,M,0,L),encontraColuna(E,L,0,J),IJ is mod(J+1,5), getByIndice(IJ,L,0,R).

correspondente(E,E1,M,R,R1) :- encontraLinha(E,M,0,I),encontraLinha(E1,M,0,I1),
								getByIndice(I,M,0,L1),getByIndice(I1,M,0,L2),
								encontraColuna(E,L1,0,J1),encontraColuna(E1,L2,0,J2),
								getByIndice(J2,L1,0,R), getByIndice(J1,L2,0,R1).

getByIndice(I,[E|_],I, E).
getByIndice(I,[_|L],IA, R) :- getByIndice(I,L,IB,R), IA is IB-1.

cifraMensagem([], _,'').
cifraMensagem([A,B|C],M,R):- estaNaMesmaLinha(A,M,B), letraDaDireita(A,M,AD), letraDaDireita(B,M,BD), string_concat(AD,BD,X), cifraMensagem(C,M, R1), string_concat(X,R1, R2), R = R2.
cifraMensagem([A,B|C],M,R):- estaNaMesmaColuna(A,M,B),letraDeBaixo(A,M,AB), letraDeBaixo(B,M,BB), string_concat(AB,BB,X), cifraMensagem(C, M,R1), string_concat(X,R1, R2), R = R2.
cifraMensagem([A,B|C],M,R):- correspondente(A,B,M,AC,BC), string_concat(AC,BC,X), cifraMensagem(C,M, R1), string_concat(X,R1, R2), R = R2.

quatroAquatro([], []).
quatroAquatro([A,B|[]], R) :- R = [A,B].
quatroAquatro([A,B,C,D|[]], R) :- R = [A,B,C,D].
quatroAquatro([A,B,C,D|T], R) :- append([A,B,C,D], [' '], R1), quatroAquatro(T, R2), append(R1, R2, R).

cabeca([H|_], H).
cauda([_|T], T).

colocaX(Lista, [], R) :- append([Lista], ['X'], LX), R = LX.
colocaX(Lista, [Lista|Cauda], [Lista|['X'|S]]) :- colocaX(Lista,Cauda,S).
colocaX(Lista, [Cabeca|Cauda], [Lista|S]) :- colocaX(Cabeca,Cauda,S).

retiraEspaco(_, [] , []).
retiraEspaco(L, [L|T], G):- retiraEspaco(L, T, G).
retiraEspaco(L, [H|T] , [H|G]):- retiraEspaco(L, T, G).

removeInvalidos([], []).
removeInvalidos([H|T], FraseValida) :- is_alpha(H), removeInvalidos(T, R), append([H], R, R1), FraseValida = R1.
removeInvalidos([H|T], FraseValida) :- \+ is_alpha(H), removeInvalidos(T, R), FraseValida = R.


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

execute(1,M) :- 
	read(M2),
	string_chars(M2,Mensagem1),
	removeInvalidos(Mensagem1, Mensagem),
	retiraEspaco(' ', Mensagem, MensagemSemEspaco),
	cauda(MensagemSemEspaco, AuxCauda),
	cabeca(MensagemSemEspaco, AuxCabeca),
	colocaX(AuxCabeca, AuxCauda, MensagemX),
	cifraMensagem(MensagemX,M,R), string_chars(R,RL),quatroAquatro(RL,RF),atomic_list_concat(RF,RFF),write(RFF),nl, main2(M).

execute(2,M) :- escreveMatriz(M),main2(M).
execute(3,M) :- matrizAleatoria(M,M1), escreveMatriz(M1),main2(M1).
execute(4,_) :- encerra,main.


main2(M):-
	write("Digite o numero da opcao:"),nl,
	write("1. Introduzir uma mensagem para cifrar"),nl,
	write("2. Ver o alfabeto"),nl,
	write("3. Escolher uma tabela de cifra nova"),nl,
	write("4. Terminar\n" ),nl,

	read(L),
	execute(L,M),nl.


:- initialization main.

main:-
	write("Digite o numero da opcao:"),nl,
	write("1. Introduzir uma mensagem para cifrar"),nl,
	write("2. Ver o alfabeto"),nl,
	write("3. Escolher uma tabela de cifra nova"),nl,
	write("4. Terminar\n" ),nl,
	matriz(_,M),

	read(L),
	execute(L,M),nl.
	
	
