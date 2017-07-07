main :: IO ()
main = do
  let tabela = ([["Y","Q","D","L","G"],
                  ["M","J","X","F","U"],
                  ["V","W","C","P","B"],
                  ["O","S","K","R","E"],
                  ["T","H","N","A","I"]])
  mostrarMenuDeOpcoes
  opcao <- getLine
  --mensagemPreparada <- getLine
  --let msgpreparada = read mensagemPreparada
  --let cifrada = cifraMensagem tabela msg
  --print (cifrada)
  -- let value = opcaoSelecionada opcao tabela -- usar isso quando descobrir como colocar tipo genérico
  print "so pra nao dar erro"


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
  
opcaoSelecionada :: String -> [[String]] -> String -- Verificar como colocar tipo genérico
opcaoSelecionada opcao tabela 
                       | (opcao == "1") = "Opcao 1"
                       | (opcao == "2") = "Opcao 2"
                       | (opcao == "3") = "Opcao 3"
                       | (opcao == "4") = "Opcao 4"
                       | (opcao == "5") = "Opcao 5"
                       | (opcao == "6") = "Programa encerrado."
                       | otherwise = "Digite uma opcao valida"


mostrarTabela :: [[String]] -> [[String]]
mostrarTabela tabela = take 5 tabela

estaNaMesmaLinha :: [[String]] -> String -> String -> Bool
estaNaMesmaLinha tabela primeiraLetra segundaLetra = if (getLinhaNaMatriz tabela primeiraLetra 4) == (getLinhaNaMatriz tabela segundaLetra 4)
                                                    then True else False

getLinhaNaMatriz :: [[String]] -> String -> Int -> Int
getLinhaNaMatriz tabela letra 0 = if elem letra (tabela !! 0) then 0 else -1
getLinhaNaMatriz tabela letra indiceLinha = if elem letra (tabela !! indiceLinha) then indiceLinha 
                                       else getLinhaNaMatriz tabela letra (indiceLinha-1)

estaNaMesmaColuna ::  [[String]] -> String -> String -> Bool
estaNaMesmaColuna tabela primeiraLetra segundaLetra = if getColunaNaMatriz tabela primeiraLetra (getLinhaNaMatriz tabela primeiraLetra 4) 4 
                                                      == getColunaNaMatriz tabela segundaLetra (getLinhaNaMatriz tabela segundaLetra 4) 4 
                                                      then True else False

getColunaNaMatriz :: [[String]] -> String -> Int -> Int -> Int
getColunaNaMatriz tabela letra indiceLinha 0 = if tabela !! indiceLinha !! 0 == letra then 0 else -1
getColunaNaMatriz tabela letra indiceLinha indiceColuna = if tabela !! indiceLinha !! indiceColuna == letra
                                                          then indiceColuna 
                                                          else getColunaNaMatriz tabela letra indiceLinha (indiceColuna-1)

letraDaDireita :: [[String]] -> String -> String
letraDaDireita tabela letra = let linha = getLinhaNaMatriz tabela letra 4 in let coluna = getColunaNaMatriz tabela letra linha 4 in
                              tabela !! linha !! ((coluna+1)`mod`5)

letraDeBaixo :: [[String]] -> String -> String
letraDeBaixo tabela letra = let linha = getLinhaNaMatriz tabela letra 4 in let coluna = getColunaNaMatriz tabela letra linha 4 in
                            tabela !! ((linha+1)`mod`5) !! coluna

correspondente :: [[String]] -> String -> String -> String
correspondente tabela primeiraLetra segundaLetra = let linha = getLinhaNaMatriz tabela primeiraLetra 4 in 
                                                   let coluna = getColunaNaMatriz tabela segundaLetra (getLinhaNaMatriz tabela segundaLetra 4) 4 in
                                                   tabela !! linha !! coluna

cifraMensagem :: [[String]] -> [String] -> [String] -- A mensagem recebida deve ser no formato: 
                                                    --["E","X","E","S","T","A","C","I","F","R","A","E","I","N","Q","U","E","B","R","A","V","E","L","X"]
cifraMensagem tabela [] = []
cifraMensagem tabela (a:b:mensagemPreparada) = if estaNaMesmaLinha tabela a b then [letraDaDireita tabela a] ++ [letraDaDireita tabela b]
                                                 ++ cifraMensagem tabela mensagemPreparada else 
                                                      if estaNaMesmaColuna tabela a b then [letraDeBaixo tabela a] ++ [letraDeBaixo tabela b] ++ cifraMensagem tabela mensagemPreparada 
                                                      else [correspondente tabela a b] ++ [correspondente tabela b a] ++ cifraMensagem tabela mensagemPreparada