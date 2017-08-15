cabeca([Cabeca|Cauda], Cauda).
cauda([Cabeca|Cauda], Cauda).

retiraCaractereInvalido(Lista, [] , []).
retiraCaractereInvalido(Lista, [Lista|Cauda], ['w'|G]):- retiraCaractereInvalido(Lista, Cauda, G).
retiraCaractereInvalido(Lista, [Cabeca|Cauda] , [Cabeca|G]):- retiraCaractereInvalido(Lista, Cauda, G).

colocaX('',[Cabeca|Cauda], [Cabeca]).
colocaX(Cabeca,[Cabeca|Cauda], G) :- cabeca(Cauda,CabecaCauda), colocaX(CabecaCauda,Cabeca,S), N is ['x'|S] , G is [Cabeca|N].
colocaX(X,[Cabeca|Cauda], G) :- cabeca(Cauda,CabecaCauda), colocaX(CabecaCauda,Cauda,S), G is [Cabeca|S].

matriz([['a','b','c','d','e'],['f','g','h','i','j'], ['k','l','m','n','o'], ['p','q','r','s','t'], ['u','v','w','x','z']]).


:- initialization main.

main:-

	read_line_to_codes(user_input, M),
	string_to_atom(M,M2),
	string_chars(M2,Mensagem),
	retiraCaractereInvalido(' ',Mensagem,MensagemSemEspaco),
	cauda(SemEspaco,Cauda),
	cabeca(Cauda,CabecaCauda),
	colocaX(CabecaCauda,SemEspaco,MensagemComX), 
	write(MensagemComX).
