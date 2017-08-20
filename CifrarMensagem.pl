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

getByIndice(I,[E|L],I, R) :- R is E.
getByIndice(I,[_|L],IA, R) :- getByIndice(I,L,IA2,R), IA is IA2+1.

% letraDeBaixo(letra,R) :- encontraLinha(letra,4,I),encontraColuna(letra,4,J),linha(I+1,L),getByIndice(J,L,4,Z), R is Z.


cabeca([Cabeca|Cauda], Cauda).
cauda([Cabeca|Cauda], Cauda).

retiraCaractereInvalido(Lista, [] , []).

retiraCaractereInvalido(Lista, [Lista|Cauda], ['w'|G]):- retiraCaractereInvalido(Lista, Cauda, G).
retiraCaractereInvalido(Lista, [Cabeca|Cauda] , [Cabeca|G]):- retiraCaractereInvaVlido(Lista, Cauda, G).

colocaX('',[Cabeca|Cauda], [Cabeca]).
colocaX(Cabeca,[Cabeca|Cauda], G) :- cabeca(Cauda,CabecaCauda), colocaX(CabecaCauda,Cabeca,S), N is ['x'|S] , G is [Cabeca|N].
colocaX(X,[Cabeca|Cauda], G) :- cabeca(Cauda,CabecaCauda), colocaX(CabecaCauda,Cauda,S), G is [Cabeca|S].

matriz([['a','b','c','d','e'],['f','g','h','i','j'], ['k','l','m','n','o'], ['p','q','r','s','t'], ['u','v','w','x','z']]).

:- initialization main.

main:-

	/*read_line_to_codes(user_input, M),
	string_to_atom(M,M2),
	string_chars(M2,Mensagem),
	retiraCaractereInvalido(' ',Mensagem,MensagemSemEspaco),
	cauda(SemEspaco,Cauda),
	cabeca(Cauda,CabecaCauda),
	colocaX(CabecaCauda,SemEspaco,MensagemComX),*/
	letraDeBaixo('A',R),

	write(R).
