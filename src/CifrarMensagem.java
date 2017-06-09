import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

public class CifrarMensagem {

	public static final int NOVA_CIFRA = 1;
	public static final int CIFRAR_MENSAGEM = 2;
	public static final int VER_MENSAGEM_CIFRADA = 3;
	public static final int DECIFRAR_MENSAGEM = 4;
	public static final int VER_ALFABETO = 5;
	public static final int TERMINAR = 6;
	
	public static final int TAMANHO_MATRIZ = 5;

	public static String[][] tabela;

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		tabela = gerarTabela();

		String mensagemDecifrada = "Voce ainda nao introduziu uma mensagem para cifrar.";
		String mensagemCifrada = "Voce ainda nao introduziu uma mensagem para cifrar.";

		int opcao = -1;
		
		while (opcao != TERMINAR) {
			mostrarMenuDeOpcoes();
			opcao = sc.nextInt();
			sc.nextLine();

			System.out.println();
			
			switch (opcao) {
				case NOVA_CIFRA:
					tabela = gerarTabela();
					System.out.println("A tabela da cifra foi atualizada!");
					break;
					
				case CIFRAR_MENSAGEM:
					System.out.print("Digite a mensagem que sera cifrada: ");
					mensagemDecifrada = sc.nextLine().toUpperCase();
					mensagemCifrada = cifraMensagem(mensagemDecifrada);
					System.out.println("Mensagem cifrada com sucesso!");
					break;

				case VER_MENSAGEM_CIFRADA:
					System.out.print("Essa eh a sua mensagem cifrada: ");
					System.out.println(mensagemCifrada);
					break;
					
				case DECIFRAR_MENSAGEM:
					System.out.print("Essa eh a sua mensagem original: ");
					System.out.println(mensagemDecifrada);
					break;
					
				case VER_ALFABETO:
					System.out.println("Tabela da cifra: ");
					imprimeTabela();
					break;
					
				case TERMINAR:
					break;
					
				default:
					mostrarMenuDeOpcoes();
					break;
			}
			System.out.println();
		}
		
		sc.close();
	}

	public static void imprimeTabela() {
		for (int i = 0; i < TAMANHO_MATRIZ; i++) {
			for (int j = 0; j < TAMANHO_MATRIZ; j++) {
					if(j == TAMANHO_MATRIZ-1) {
						System.out.println(tabela[i][j]);
					} else {
						System.out.print(tabela[i][j] + " ");
					}
			}
		}
	}

	public static void mostrarMenuDeOpcoes() {
		System.out.println("Escolha uma das opcoes abaixo: \n");

		System.out.println("1. Escolher uma tabela de cifra nova");
		System.out.println("2. Introduzir uma mensagem para cifrar");
		System.out.println("3. Ver a mensagem cifrada");
		System.out.println("4. Decifrar a mensagem");
		System.out.println("5. Ver o alfabeto");
		System.out.println("6. Terminar \n");

		System.out.print("Opcao: ");
	}

	public static String[][] gerarTabela() {

		String alfabeto = "ABCDEFGHIJKLMNOPQRSTUVXWZ";
		String[] alfabetoArray = alfabeto.split("");

		// Copia em ArrayList para usar o shuffle.
		ArrayList<String> alfabetoArrayList = new ArrayList<>();
		for (int i = 0; i < alfabetoArray.length; i++) {
			alfabetoArrayList.add(alfabetoArray[i]);
		}
		
		// Embaralha o alfabeto para uma nova cifra.
		Collections.shuffle(alfabetoArrayList);

		// Monta a matriz a partir do alfabeto do ArrayList.
		String[][] novaTabela = new String[TAMANHO_MATRIZ][TAMANHO_MATRIZ];
		int letraContador = 0;

		for (int i = 0; i < TAMANHO_MATRIZ; i++) {
			for (int j = 0; j < TAMANHO_MATRIZ; j++) {
				novaTabela[i][j] = alfabetoArrayList.get(letraContador);
				letraContador++;
			}
		}

		return novaTabela;
	}

	public static String cifraMensagem(String mensagemDescriptografada) {
		String mensagemCriptografada = "", primeiraLetra, segundaLetra;
		String mensagemPreparada = preparaMensagem(mensagemDescriptografada);

		boolean juntaPares = true;
		
		for (int i = 0; i < mensagemPreparada.length(); i+=3) {
			primeiraLetra = String.valueOf(mensagemPreparada.charAt(i));
			segundaLetra = String.valueOf(mensagemPreparada.charAt(i+1));
			
			if (estaNaMesmaLinha(primeiraLetra, segundaLetra)) {
				mensagemCriptografada += letraDaDireita(primeiraLetra);
				mensagemCriptografada += letraDaDireita(segundaLetra);
			} else if (estaNaMesmaColuna(primeiraLetra, segundaLetra)) {
				mensagemCriptografada += letraDeBaixo(primeiraLetra);
				mensagemCriptografada += letraDeBaixo(segundaLetra);
			} else {
				mensagemCriptografada += correspondente(primeiraLetra, segundaLetra);
				mensagemCriptografada += correspondente(segundaLetra, primeiraLetra);

			}
			
			mensagemCriptografada += (juntaPares ? "" : " ");
			juntaPares = !juntaPares;
		}
		
		return mensagemCriptografada;
	}

	public static String preparaMensagem(String mensagem) {
		String mensagemPreparada = "";

		for (int i = 0; i < mensagem.length(); i++) {
			mensagemPreparada += String.valueOf(mensagem.charAt(i));
			
			if (i == (mensagem.length()-1) || mensagem.charAt(i) == mensagem.charAt(i+1)) {
				mensagemPreparada += "X ";
			} else {
				mensagemPreparada += String.valueOf(mensagem.charAt(i+1)) + " ";
				i++;
			}
		}
		
		return mensagemPreparada.trim();
	}

	private static boolean estaNaMesmaLinha(String primeiraLetra, String segundaLetra) {
		int linha = getLinhaNaMatriz(primeiraLetra);
		
		int coluna = 0;
		
		while (coluna < TAMANHO_MATRIZ) {
			if (tabela[linha][coluna].equalsIgnoreCase(segundaLetra)){
				return true;
			}
			
			coluna++;
		}

		return false;
	}
	
	private static boolean estaNaMesmaColuna(String primeiraLetra, String segundaLetra) {
		int coluna = getColunaNaMatriz(primeiraLetra);
		
		int linha = 0;
		
		while (linha < TAMANHO_MATRIZ) {
			if (tabela[linha][coluna].equalsIgnoreCase(segundaLetra)){
				return true;
			}
			
			linha++;
		}

		return false;
	}
	
	private static String letraDaDireita(String letra) {
		int linha = getLinhaNaMatriz(letra);
		int coluna = getColunaNaMatriz(letra);

		return tabela[linha][(coluna + 1) % TAMANHO_MATRIZ];
	}
	
	private static String letraDeBaixo(String letra) {
		int linha = getLinhaNaMatriz(letra);
		int coluna = getColunaNaMatriz(letra);
		
		return tabela[(linha + 1) % TAMANHO_MATRIZ][coluna];
	}
	
	private static String correspondente(String primeiraLetra, String segundaLetra) {
		int linha = getLinhaNaMatriz(primeiraLetra);
		int coluna = getColunaNaMatriz(segundaLetra);
		
		return tabela[linha][coluna];
	}
	
	private static int getLinhaNaMatriz(String letra) {
		boolean encontrada = false;
		int linha = 0, coluna = 0;
		
		while (!encontrada && linha < TAMANHO_MATRIZ) {
			while (!encontrada && coluna < TAMANHO_MATRIZ) {
				if (tabela[linha][coluna].equalsIgnoreCase(letra)) {
					encontrada = true;
				}
				if (!encontrada) coluna++;
			}
			if (!encontrada) {
				linha++;
				coluna = 0;
			}
		}
		
		return linha;
	}
	
	private static int getColunaNaMatriz(String letra) {
		boolean encontrada = false;
		int linha = 0, coluna = 0;
		
		while (!encontrada && linha < TAMANHO_MATRIZ) {
			while (!encontrada && coluna < TAMANHO_MATRIZ) {
				if (tabela[linha][coluna].equalsIgnoreCase(letra)) {
					encontrada = true;
				}
				if (!encontrada) coluna++;
			}
			if (!encontrada) {
				linha++;
				coluna = 0;
			}
		}
		
		return coluna;
	}
}