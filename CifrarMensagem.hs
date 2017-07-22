import Data.Char

_CIFRAR_MENSAGEM = 1
_INDICE_TABELA = 4
_TAMANHO_TABELA = 5
_TABELA = ([['Y','Q','D','L','G'],
			['M','J','X','F','U'],
			['V','W','C','P','B'],
			['O','S','K','R','E'],
			['T','H','N','A','I']])

main :: IO ()
main = do
  mostrarMenuDeOpcoes
  
  opcaoArgs <- getLine
  let opcao = read opcaoArgs
  
  mensagemArgs <- getLine
  let mensagem = read mensagemArgs
  
  let mensagemPreparada = preparaMensagem mensagem
  let resultadoProcessamento = processa opcao mensagemPreparada
  
  putStrLn ("\n")
  
  if not (ehVazia resultadoProcessamento) then do
	{ putStrLn (resultadoProcessamento ++ "\n"); main }
  else do
    { putStrLn ("Volte sempre! :)") }

preparaMensagem :: String -> String
preparaMensagem frase = juntaDoisADois fraseValida
    where fraseValida = removeCaracInvalidos frase

juntaDoisADois :: String -> String
juntaDoisADois [] = ""
juntaDoisADois (x:[]) = (x:'X':[])
juntaDoisADois (x:y:xs) = if x == y then (x:'X':[]) ++ juntaDoisADois (y:xs)
						  else(x:y:[]) ++ juntaDoisADois xs

removeCaracInvalidos :: String -> String
removeCaracInvalidos frase = [ x | x <- frase, isLetter x ]

mostrarMenuDeOpcoes :: IO()
mostrarMenuDeOpcoes = do
  putStrLn ("Escolha uma das opcoes abaixo:\n")
  putStrLn ("1. Cifrar mensagem")
  putStrLn ("2. Ver o alfabeto")
  putStrLn ("3. Terminar\n")
  putStrLn ("Opcao: ")

processa :: Int -> String -> String
processa 1 mensagem = adicionaEspacoCadaQuatro (cifraMensagem mensagem)
processa 2 mensagem = transformaTabela _TABELA
processa opcaoInvalida mensagem = ""

transformaTabela :: [[Char]] -> String
transformaTabela [] = ""
transformaTabela (x:xs) = adicionaEspacoEntreCaracters x ++ "\n" ++ transformaTabela xs

adicionaEspacoEntreCaracters :: String -> String
adicionaEspacoEntreCaracters [] = ""
adicionaEspacoEntreCaracters (x:xs) = x:' ':[] ++ adicionaEspacoEntreCaracters xs

ehVazia :: String -> Bool
ehVazia "" = True
ehVazia string = False

estaNaMesmaLinha :: Char -> Char -> Bool
estaNaMesmaLinha primeiraLetra segundaLetra = indiceLinhaPrimeiraLetra == indiceLinhaSegundaLetra
    where indiceLinhaPrimeiraLetra = getLinhaNaMatriz primeiraLetra _INDICE_TABELA
          indiceLinhaSegundaLetra  = getLinhaNaMatriz segundaLetra _INDICE_TABELA

getLinhaNaMatriz :: Char -> Int -> Int
getLinhaNaMatriz letra 0 = if letra `elem` (_TABELA !! 0) then 0 else -1
getLinhaNaMatriz letra indiceLinha = if letra `elem` linhaAtual then indiceLinha 
                                     else getLinhaNaMatriz letra (indiceLinha-1)
    where linhaAtual = _TABELA !! indiceLinha

estaNaMesmaColuna :: Char -> Char -> Bool
estaNaMesmaColuna primeiraLetra segundaLetra = indiceColunaPrimeiraLetra == indiceColunaSegundaLetra
    where indiceColunaPrimeiraLetra = getColunaNaMatriz primeiraLetra (getLinhaNaMatriz primeiraLetra _INDICE_TABELA) _INDICE_TABELA
          indiceColunaSegundaLetra  = getColunaNaMatriz segundaLetra (getLinhaNaMatriz segundaLetra _INDICE_TABELA) _INDICE_TABELA

getColunaNaMatriz :: Char -> Int -> Int -> Int
getColunaNaMatriz letra indiceLinha 0 = if letra == _TABELA !! indiceLinha !! 0 then 0 else -1
getColunaNaMatriz letra indiceLinha indiceColuna = if letra == letraDaColunaAtual then indiceColuna 
												   else getColunaNaMatriz letra indiceLinha (indiceColuna-1)
    where letraDaColunaAtual = _TABELA !! indiceLinha !! indiceColuna

letraDaDireita :: Char -> Char
letraDaDireita letra = let linha = getLinhaNaMatriz letra _INDICE_TABELA in let coluna = getColunaNaMatriz letra linha _INDICE_TABELA in
                              _TABELA !! linha !! ((coluna+1) `mod` _TAMANHO_TABELA)

letraDeBaixo :: Char -> Char
letraDeBaixo letra = let linha = getLinhaNaMatriz letra _INDICE_TABELA in let coluna = getColunaNaMatriz letra linha _INDICE_TABELA in
                            _TABELA !! ((linha+1) `mod` _TAMANHO_TABELA) !! coluna

correspondente :: Char -> Char -> Char
correspondente primeiraLetra segundaLetra = let linha = getLinhaNaMatriz primeiraLetra _INDICE_TABELA in 
                                                   let coluna = getColunaNaMatriz segundaLetra (getLinhaNaMatriz segundaLetra _INDICE_TABELA) _INDICE_TABELA in
                                                   _TABELA !! linha !! coluna

adicionaEspacoCadaQuatro :: String -> String
adicionaEspacoCadaQuatro frase = if length frase <= 4 then frase
							  else take 4 frase ++ " " ++ adicionaEspacoCadaQuatro (drop 4 frase)

cifraMensagem :: String -> String
cifraMensagem [] = []
cifraMensagem (a:b:cs) =  if estaNaMesmaLinha a b then letraDaDireita a : letraDaDireita b : cifraMensagem cs
						  else if estaNaMesmaColuna a b then letraDeBaixo a : letraDeBaixo b : cifraMensagem cs
						  else correspondente a b : correspondente b a : cifraMensagem cs
