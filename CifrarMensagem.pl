3 ?- use_module(library(random)).

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

getByIndice(I,[E|L],I, E).
getByIndice(I,[_|L],IA, R) :- getByIndice(I,L,IA2,R), IA is IA2-1.

cabeca([Cabeca|Cauda], Cauda).
cauda([Cabeca|Cauda], Cauda).

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

execute(5) :- matriz(A,M), escreveMatriz(M).
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
