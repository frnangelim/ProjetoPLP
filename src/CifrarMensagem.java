import java.util.ArrayList;
import java.util.Collections;
import java.util.Map;
import java.util.Scanner;

public class CifrarMensagem {

    public static final int NOVA_CIFRA = 1;
    public static final int CIFRAR_MENSAGEM = 2;
    public static final int VER_MENSAGEM_CIFRADA = 3;
    public static final int DECIFRAR_MENSAGEM = 4;
    public static final int VER_ALFABETO = 5;
    public static final int TERMINAR = 6;

    public static void main(String[] args){

        Scanner reader = new Scanner(System.in);
        String[][] table = generateTable();

        String decryptedMessage = "Você ainda não introduziu uma mensagem para cifrar.";
        String encryptedMessage = "Você ainda não introduziu uma mensagem para cifrar.";

        int option = -1;
        while(option != 6){
            showMenu();
            option = reader.nextInt();
            reader.nextLine();

            switch(option){
                case NOVA_CIFRA:
                    table = generateTable();
                    System.out.println("A tabela da cifra foi atualizada!");
                    break;
                case CIFRAR_MENSAGEM:
                    System.out.print("Digite a mensagem que será cifrada: ");
                    decryptedMessage = reader.nextLine();
                    ArrayList<String> phrase = makePhraseToEncrypt(decryptedMessage); // Mensagem apenas preparada para ser encriptada

                    /* Do jeito que tá atualmente vai ter um problema na hora de encriptar,
                     fiz a matriz com array normal, ai pra saber se estão na mesma linha/coluna ou outras operações do tipo
                     não vai dar certo, tem que usar alguma outra estrutura.
                     OU
                     Percorrer toda vez pra achar o elemento e comparar o I e J.
                     */
                    // TODO
                    break;
                case VER_MENSAGEM_CIFRADA:
                    System.out.print("Essa é a sua mensagem cifrada: ");
                    System.out.println(encryptedMessage);
                    break;
                case DECIFRAR_MENSAGEM:
                    System.out.print("Essa é a sua mensagem original: ");
                    System.out.println(decryptedMessage);
                    // TODO
                    break;
                case VER_ALFABETO:
                    System.out.println("Tabela da cifra: ");
                    for(int i = 0; i < 5; i++){
                        for(int j = 0; j < 5; j++){
                            if(j == 4){
                                System.out.println(table[i][j]);
                            }else{
                                System.out.print(table[i][j]);
                            }
                        }
                    }
                    break;
                case TERMINAR:
                    break;
                default:
                    showMenu();
                    break;
            }
            System.out.println("");
        }
    }

    public static String[][] generateTable(){

        String alphabet = "ABCDEFGHIJKLMNOPQRSTUVXWZ";
        String[] arrayAlphabet = alphabet.split("");

        // Cópia em ArrayList para usar o shuffle.
        ArrayList<String> mAlphabet = new ArrayList<>();
        for(int i = 0; i < arrayAlphabet.length; i++){
            mAlphabet.add(arrayAlphabet[i]);
        }
        Collections.shuffle(mAlphabet); // Embaralha o alfabeto para uma nova cifra.


        // Monta a matriz a partir do alfabeto do ArrayList.
        String[][] newTable = new String[5][5];
        int letterCont = 0;

        for(int i = 0; i < 5; i++){
            for(int j = 0; j < 5; j++){
                newTable[i][j] = mAlphabet.get(letterCont);
                letterCont++;
            }
        }

        return newTable;
    }

    public static ArrayList<String> makePhraseToEncrypt(String phrase){
        // Remoção de espaço e pontuações.
        phrase = phrase.trim();
        phrase = phrase.replaceAll(",", "");
        phrase = phrase.replaceAll("\\.", "");
        phrase = phrase.replaceAll(" ", "");
        phrase = phrase.replaceAll("!", "");
        phrase = phrase.replaceAll("\\?", "");

        String[] newPhrase = phrase.split("");

        ArrayList<String> mPhrase = new ArrayList<>();
        // Cópia em ArrayList
        for(int i = 0; i < newPhrase.length; i++){
            mPhrase.add(newPhrase[i]);
        }

        for(int i = 0; i < mPhrase.size(); i++){
            if(i == mPhrase.size()-1 && mPhrase.size() % 2 != 0){ // Se a última letra sobrar. Exemplo : Iae oi -- > IA EO IX
                mPhrase.add("X");
                i++;
            }else if (i < mPhrase.size()-1 &&
                    mPhrase.get(i).equals(mPhrase.get(i+1))) { // Se dois caractéres forem iguais. Exemplo: Iaae --> IA XE
                mPhrase.add(i+1, "X");
                i++;
            }
        }
        return mPhrase;
    }

    public static void showMenu(){
        System.out.println("Escolha uma das opções abaixo: \n");

        System.out.println("1. Escolher uma tabela de cifra nova");
        System.out.println("2. Introduzir uma mensagem para cifrar");
        System.out.println("3. Ver a mensagem cifrada");
        System.out.println("4. Decifrar a mensagem");
        System.out.println("5. Ver o alfabeto");
        System.out.println("6. Terminar \n");

        System.out.print("Opção: ");
    }

}
