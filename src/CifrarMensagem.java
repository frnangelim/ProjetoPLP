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

	public static String[][] tabela;

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		tabela = gerarTabela();

		String mensagemDescriptografada = "Voce ainda nao introduziu uma mensagem para cifrar.";
		String mensagemEncriptografa = "Voce ainda nao introduziu uma mensagem para cifrar.";

		int opcao = -1;
		
		while (opcao != TERMINAR) {
			mostrarMenuDeOpcoes();
			opcao = sc.nextInt();
			sc.nextLine();

			switch (opcao) {
				case NOVA_CIFRA:
					tabela = gerarTabela();
					System.out.print("A tabela da cifra foi atualizada!");
					break;
					
				case CIFRAR_MENSAGEM:
					System.out.print("Digite a mensagem que sera cifrada: ");
					mensagemDescriptografada = sc.nextLine().toUpperCase();
					mensagemEncriptografa = criptografaMensagem(mensagemDescriptografada);
					break;

				case VER_MENSAGEM_CIFRADA:
					System.out.print("Essa eh a sua mensagem cifrada: ");
					System.out.print(mensagemEncriptografa);
					break;
					
				case DECIFRAR_MENSAGEM:
					System.out.print("Essa eh a sua mensagem original: ");
					System.out.print(mensagemDescriptografada);
					break;
					
				case VER_ALFABETO:
					System.out.println("Tabela da cifra: ");
					for (int i = 0; i < 5; i++) {
						for (int j = 0; j < 5; j++) {
								System.out.print(tabela[i][j]);
						}
					}
					System.out.println();
					break;
					
				case TERMINAR:
					break;
					
				default:
					mostrarMenuDeOpcoes();
					break;
			}
			
			System.out.println("");
		}
		
		sc.close();
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
		String[][] novaTabela = new String[5][5];
		int letraContador = 0;

		for (int i = 0; i < 5; i++) {
			for (int j = 0; j < 5; j++) {
				novaTabela[i][j] = alfabetoArrayList.get(letraContador);
				letraContador++;
			}
		}

		return novaTabela;
	}

	public static String criptografaMensagem(String mensagemDescriptografada) {
		String mensagemEncriptografada = preparaMensagem(mensagemDescriptografada);

		return mensagemEncriptografada;
	}
	
	public static String preparaMensagem(String mensagem) {
		String mensagemPreparada = "";
		
		mensagem = removeCaracteresInvalidos(mensagem);

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
	
	private static String removeCaracteresInvalidos(String phrase) {
		phrase.trim();
		phrase = phrase.replaceAll(",", "");
		phrase = phrase.replaceAll("\\.", "");
		phrase = phrase.replaceAll(" ", "");
		phrase = phrase.replaceAll("!", "");
		phrase = phrase.replaceAll("\\?", "");
		
		return phrase;
	}

	// Metodo para verificar se as duas letras estao na mesma linha
	private boolean estaNaMesmaLinha(String primeiraLetra, String segundaLetra) {
		int linha = getLinhaNaMatriz(primeiraLetra);
		
		for (int i = 0; i < tabela.length; i++) {
			if (tabela[linha][i].equalsIgnoreCase(segundaLetra)){
				return true;
			}
		}

		return false;
	}
	
	
	private int getLinhaNaMatriz(String letra) {
		boolean encontrada = false;
		int linha = 0, coluna = 0;
		
		while (!encontrada && linha < tabela.length) {
			while (!encontrada && coluna < tabela.length) {
				if (tabela[linha][coluna].equalsIgnoreCase(letra)) {
					encontrada = true;
				}
				coluna++;
			}
			linha++;
		}
		
		return linha;
	}
	
	private int getColunaNaMatriz(String letra) {
		boolean encontrada = false;
		int linha = 0, coluna = 0;
		
		while (!encontrada && linha < tabela.length) {
			while (!encontrada && coluna < tabela.length) {
				if (tabela[linha][coluna].equalsIgnoreCase(letra)) {
					encontrada = true;
				}
				coluna++;
			}
			linha++;
		}
		
		return coluna;
	}
}