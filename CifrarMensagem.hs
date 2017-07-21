_tabela = ([["Y","Q","D","L","G"],
                  ["M","J","X","F","U"],
                  ["V","W","C","P","B"],
                  ["O","S","K","R","E"],
                  ["T","H","N","A","I"]])
_indiceTabela = 4
_tamanhoTabela = 5

main :: IO ()
main = do
  mostrarMenuDeOpcoes
  opcaoArg <- getLine
  --putStrLn ("\n")
  let opcao = read opcaoArg
  let resultadoProcessamento = processa opcao
  --mensagemPreparada <- getLine
  --let msgpreparada = read mensagemPreparada
  --let cifrada = cifraMensagem tabela msgpreparada
  putStrLn ("\n" ++ resultadoProcessamento ++ "\n")
  main

processa :: Int -> String
processa 1 = "Opcao 1 nao implementada"
processa 2 = "Opcao 2 nao implementada"
processa 3 = "Opcao 3 nao implementada"
processa 4 = "Opcao 4 nao implementada"
processa 5 = imprimeTabela _tabela
processa 6 = cifraMensagem ["E","X","E","S","T","A","C","I","F","R","A","E","I","N","Q","U","E","B","R","A","V","E","L","X"]

imprimeTabela :: [[String]] -> String
imprimeTabela [] = ""
imprimeTabela (x:xs) = unwords x ++ "\n" ++ imprimeTabela xs

mostrarMenuDeOpcoes :: IO()
mostrarMenuDeOpcoes = do 
  putStrLn ("Escolha uma das opcoes abaixo:\n")
  putStrLn ("1. Escolher uma tabela de cifra nova")
  putStrLn ("2. Introduzir uma mensagem para cifrar")
  putStrLn ("3. Ver a mensagem cifrada")
  putStrLn ("4. Decifrar a mensagem")
  putStrLn ("5. Ver o alfabeto")
  putStrLn ("6. Terminar\n")
  putStrLn ("Opcao: ")

estaNaMesmaLinha :: String -> String -> Bool
estaNaMesmaLinha primeiraLetra segundaLetra = indiceLinhaPrimeiraLetra == indiceLinhaSegundaLetra
    where indiceLinhaPrimeiraLetra = getLinhaNaMatriz primeiraLetra _indiceTabela
          indiceLinhaSegundaLetra  = getLinhaNaMatriz segundaLetra _indiceTabela

getLinhaNaMatriz :: String -> Int -> Int
getLinhaNaMatriz letra 0 = if letra `elem` (_tabela !! 0) then 0 else -1
getLinhaNaMatriz letra indiceLinha = if letra `elem` linhaAtual then indiceLinha 
                                     else getLinhaNaMatriz letra (indiceLinha-1)
    where linhaAtual = _tabela !! indiceLinha

estaNaMesmaColuna :: String -> String -> Bool
estaNaMesmaColuna primeiraLetra segundaLetra = indiceColunaPrimeiraLetra == indiceColunaSegundaLetra
    where indiceColunaPrimeiraLetra = getColunaNaMatriz primeiraLetra indiceLinhaPrimeiraLetra _indiceTabela
          indiceColunaSegundaLetra  = getColunaNaMatriz segundaLetra indiceLinhaPrimeiraLetra _indiceTabela
          indiceLinhaPrimeiraLetra  = getLinhaNaMatriz primeiraLetra _indiceTabela
          indiceLinhaSegundaLetra   = getLinhaNaMatriz segundaLetra _indiceTabela

getColunaNaMatriz :: String -> Int -> Int -> Int
getColunaNaMatriz letra indiceLinha 0 = if letra == _tabela !! indiceLinha !! 0 then 0 else -1
getColunaNaMatriz letra indiceLinha indiceColuna = if letra == letraDaColunaAtual then indiceColuna 
												   else getColunaNaMatriz letra indiceLinha (indiceColuna-1)
    where letraDaColunaAtual = _tabela !! indiceLinha !! indiceColuna

letraDaDireita :: String -> String
letraDaDireita letra = let linha = getLinhaNaMatriz letra _indiceTabela in let coluna = getColunaNaMatriz letra linha _indiceTabela in
                              _tabela !! linha !! ((coluna+1) `mod` _tamanhoTabela)

letraDeBaixo :: String -> String
letraDeBaixo letra = let linha = getLinhaNaMatriz letra _indiceTabela in let coluna = getColunaNaMatriz letra linha _indiceTabela in
                            _tabela !! ((linha+1) `mod` _tamanhoTabela) !! coluna

correspondente :: String -> String -> String
correspondente primeiraLetra segundaLetra = let linha = getLinhaNaMatriz primeiraLetra _indiceTabela in 
                                                   let coluna = getColunaNaMatriz segundaLetra (getLinhaNaMatriz segundaLetra _indiceTabela) _indiceTabela in
                                                   _tabela !! linha !! coluna

-- A mensagem recebida deve ser no formato: ["E","X","E","S","T","A","C","I","F","R","A","E","I","N","Q","U","E","B","R","A","V","E","L","X"]
cifraMensagem :: [String] -> String
cifraMensagem [] = []
cifraMensagem (a:b:cs) =  if estaNaMesmaLinha a b then letraDaDireita a ++ letraDaDireita b ++ cifraMensagem cs
						  else if estaNaMesmaColuna a b then letraDeBaixo a ++ letraDeBaixo b ++ cifraMensagem cs
						  else correspondente a b ++ correspondente b a ++ cifraMensagem cs
