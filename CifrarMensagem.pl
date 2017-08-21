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


% Verifica se um elemento pertence a uma lista.
pertence(X,[X|_]).
pertence(X,[_|Y]):- pertence(X,Y).

% Encontra a linha de um elemento.
% Xqn: Tou em dúvida de como fazer a 'condicao de parada', quando o
% elemento não existe na tabela tá dando treta, anyway a gente só vai
% usar pra elementos conhecidos.

encontraLinha(E,0,0) :-	linha(0,L), pertence(E,L).
encontraLinha(E,I,R) :- linha(I,L), pertence(E,L), R is I.
encontraLinha(E,I,R) :- encontraLinha(E,I2,R), I is I2+1.
%Encontra coluna de um elemento.
encontraColuna(E,0,0) :- coluna(0,L), pertence(E,L).
encontraColuna(E,I,R) :- coluna(I,L), pertence(E,L), R is I.
encontraColuna(E,I,R) :- encontraColuna(E,I2,R), I is I2+1.


getByIndice(I,[E|L],I, E).
getByIndice(I,[_|L],IA, R) :- getByIndice(I,L,IA2,R), IA is IA2-1.

letraDeBaixo(letra,R) :- encontraLinha(letra,4,I),encontraColuna(letra,4,J),linha(B,L),B is I+1, getByIndice(J,L,0,R).

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
	write("fim da execucao"),nl,nl.


matriz([['a','b','c','d','e'],
		['f','g','h','i','j'], 
		['k','l','m','n','o'], 
		['p','q','r','s','t'], 
		['u','v','w','x','z']]).

:- initialization main.

main:-

main:-

	write("Digite o numero da opcao"),nl,
	write("1. Escolher uma tabela de cifra nova"),nl,
	write("2. Introduzir uma mensagem para cifrar"),nl,
	write("3. Ver a mensagem cifrada"),nl,
	write("4. Decifrar mensagem"),nl,
	write("5. Ver o alfabeto" ),nl,
	write("6. Terminar\n" ),nl,
	
	encontraColuna('Y',4,R),

	write(R).
