#include <iostream>
#include <algorithm>
#include <random>
#include <string>
using namespace std;

void geraTabelaPadrao();
void geraTabelaAleatoria();
void mostraMenuDeOpcoes();
void imprimeTabela();
string cifraMensagem(string mensagemDescriptografada);
string preparaMensagem(string mensagem);
string removeEspacos(string mensagem);
bool estaNaMesmaLinha(char primeiraLetra, char segundaLetra);
bool estaNaMesmaColuna(char primeiraLetra, char segundaLetra);
char letraDaDireita(char letra);
char letraDeBaixo(char letra);
char correspondente(char primeiraLetra, char segundaLetra);
int getLinhaNaMatriz(char letra);
int getColunaNaMatriz(char letra);

const int NOVA_CIFRA = 1;
const int CIFRAR_MENSAGEM = 2;
const int VER_MENSAGEM_CIFRADA = 3;
const int VER_MENSAGEM_ORIGINAL = 4;
const int VER_ALFABETO = 5;
const int TERMINAR = 6;
const int TAMANHO_MATRIZ = 5;
const string ALFABETO ("ABCDEFGHIJKLMNOPQRSTUVWXZ");

char tabela[5][5];

int main() {
	geraTabelaPadrao();
	
	string mensagemDecifrada ("Voce ainda nao introduziu uma mensagem para cifrar.");
	string mensagemCifrada ("Voce ainda nao introduziu uma mensagem para cifrar.");
	string dummy;

	int opcao = -1;

	while (opcao != TERMINAR) {
		mostraMenuDeOpcoes();
		
		cin >> opcao;
		getline(cin, dummy);
		cout << "\n";

		switch(opcao) {
			case NOVA_CIFRA:
				geraTabelaAleatoria();
				cout << "A tabela da cifra foi atualizada com sucesso!\n";
				break;
			case CIFRAR_MENSAGEM:
				cout << "Digite a mensagem que sera cifrada: ";
				getline(cin, mensagemDecifrada);
				mensagemCifrada = cifraMensagem(mensagemDecifrada);
				cout << "Mensagem cifrada com sucesso!\n";
				break;
			case VER_MENSAGEM_CIFRADA:
				cout << "Essa eh a sua mensagem cifrada: " << mensagemCifrada << "\n";
				break;
			case VER_MENSAGEM_ORIGINAL:
				cout << "Essa eh a sua mensagem original: " << mensagemDecifrada << "\n";
				break;
			case VER_ALFABETO:
				cout << "Tabela da cifra:\n";
				imprimeTabela();
				break;
			case TERMINAR:
				break;
			default:
				mostraMenuDeOpcoes();
				break;
		}
		
		cout << "\n";
	}
}

void geraTabelaPadrao() {
	tabela[0][0] = 'Y'; tabela[0][1] = 'Q'; tabela[0][2] = 'D'; tabela[0][3] = 'L'; tabela[0][4] = 'G';
	tabela[1][0] = 'M'; tabela[1][1] = 'J'; tabela[1][2] = 'X'; tabela[1][3] = 'F'; tabela[1][4] = 'U';
	tabela[2][0] = 'V'; tabela[2][1] = 'W'; tabela[2][2] = 'C'; tabela[2][3] = 'P'; tabela[2][4] = 'B';
	tabela[3][0] = 'O'; tabela[3][1] = 'S'; tabela[3][2] = 'K'; tabela[3][3] = 'R'; tabela[3][4] = 'E';
	tabela[4][0] = 'T'; tabela[4][1] = 'H'; tabela[4][2] = 'N'; tabela[4][3] = 'A'; tabela[4][4] = 'I';
}

void geraTabelaAleatoria() {
	string alfabeto (ALFABETO);
	
	shuffle (alfabeto.begin(), alfabeto.end(), random_device());
	
	string::iterator it = alfabeto.begin();
	int i, j;
	for (i = 0; i < TAMANHO_MATRIZ; i++) {
		for (j = 0; j < TAMANHO_MATRIZ; j++) {
			tabela[i][j] = *it++;
		}
	}
}

void mostraMenuDeOpcoes() {
	cout << "Escolha uma das opcoes abaixo:\n\n";
	cout << "1. Escolher uma tabela de cifra nova\n";
	cout << "2. Introduzir uma mensagem para cifrar\n";
	cout << "3. Ver a mensagem cifrada\n";
	cout << "4. Decifrar a mensagem\n";
	cout << "5. Ver o alfabeto\n";
	cout << "6. Terminar\n\n";
	cout << "Opcao: ";
}

void imprimeTabela() {
	int i, j;
	for (i = 0; i < TAMANHO_MATRIZ; i++) {
		for (j = 0; j < TAMANHO_MATRIZ; j++) {
			cout << tabela[i][j] << " ";
		}
		cout << "\n";
	}
}

string cifraMensagem(string mensagemDescriptografada) {
		string mensagemCriptografada = (""), mensagemPreparada = preparaMensagem(mensagemDescriptografada);
		char primeiraLetra, segundaLetra;

		bool juntaPares = true;
		
		for (int i = 0; i < mensagemPreparada.length(); i+=3) {
			primeiraLetra = mensagemPreparada[i];
			segundaLetra = mensagemPreparada[i+1];
			
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

string preparaMensagem(string mensagem) {
	string mensagemPreparada = ("");
	
	mensagem = removeEspacos(mensagem);

	for (int i = 0; i < mensagem.length(); i++) {
		mensagemPreparada += mensagem[i];
		
		if (i == (mensagem.length()-1) || mensagem[i] == mensagem[i+1]) {
			mensagemPreparada += "X ";
		} else {
			mensagemPreparada += mensagem[i+1];
			mensagemPreparada += " ";
			i++;
		}
	}
	
	return mensagemPreparada;
}

string removeEspacos(string mensagem) {
	string mensagemSemEspaco ("");
	
	for(int i = 0; i < mensagem.length(); i++) {
		if(mensagem[i] != ' ') {	
			mensagemSemEspaco += mensagem[i]; 
		}
	}
	
	return mensagemSemEspaco;
}

bool estaNaMesmaLinha(char primeiraLetra, char segundaLetra) {
	int linha = getLinhaNaMatriz(primeiraLetra);
	
	int coluna = 0;
	
	while (coluna < TAMANHO_MATRIZ) {
		if (tabela[linha][coluna] == segundaLetra) {
			return true;
		}
		
		coluna++;
	}

	return false;
}

bool estaNaMesmaColuna(char primeiraLetra, char segundaLetra) {
	int coluna = getColunaNaMatriz(primeiraLetra);
	
	int linha = 0;
	
	while (linha < TAMANHO_MATRIZ) {
		if (tabela[linha][coluna] == segundaLetra) {
			return true;
		}
		
		linha++;
	}

	return false;
}


char letraDaDireita(char letra) {
	int linha = getLinhaNaMatriz(letra);
	int coluna = getColunaNaMatriz(letra);

	return tabela[linha][(coluna + 1) % TAMANHO_MATRIZ];
}

char letraDeBaixo(char letra) {
	int linha = getLinhaNaMatriz(letra);
	int coluna = getColunaNaMatriz(letra);
	
	return tabela[(linha + 1) % TAMANHO_MATRIZ][coluna];
}

char correspondente(char primeiraLetra, char segundaLetra) {
	int linha = getLinhaNaMatriz(primeiraLetra);
	int coluna = getColunaNaMatriz(segundaLetra);
	
	return tabela[linha][coluna];
}

int getLinhaNaMatriz(char letra) {
	bool encontrada = false;
	int linha = 0, coluna = 0;
	
	while (!encontrada && linha < TAMANHO_MATRIZ) {
		while (!encontrada && coluna < TAMANHO_MATRIZ) {
			if (tabela[linha][coluna] == letra) {
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

int getColunaNaMatriz(char letra) {
	bool encontrada = false;
	int linha = 0, coluna = 0;
	
	while (!encontrada && linha < TAMANHO_MATRIZ) {
		while (!encontrada && coluna < TAMANHO_MATRIZ) {
			if (tabela[linha][coluna] == letra) {
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
