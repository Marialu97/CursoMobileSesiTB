import java.util.Scanner;

public class CalculadoraOperacoes {
    // atributos
    double numero1, numero2, resultado;
    String operacao;
    boolean continuar = true;

    // contrutores (vazio)

    // métodos

    // soma
    public double soma(double a, double b) {
        return a + b;
    }

    // subltiplicação
    public double subltiplicação(double a, double b) {
        return a - b;
    }

    // multiplicação
    public double multiplicação(double a, double b) {
        return a * b;
    }

    // divisão
    public double divisão(double a, double b) {
        return a / b;
    }

    // menu
    public void menu() {
        Scanner sc = new Scanner(System.in);
        do {
            System.out.println("===Calculadora Simples===");
            System.out.println("===Escolha a Operação===");
            System.out.println("1. Soma");
            System.out.println("2. Subltiplicação");
            System.out.println("3. Multiplicação");
            System.out.println("4. Divisão");
            System.out.println("5. Sair");
            System.out.println("========");
            operacao = sc.next();
            // tomada de decisão - condição
            switch (operacao) {
                case "1":
                    System.out.println("Informe o 1º nº");
                    numero1 = sc.nextDouble();
                    System.out.println("Informe o 2º nº");
                    numero2 = sc.nextDouble();
                    resultado = soma(numero1, numero2);
                    System.out.println("O resultado é " + resultado);
                    break;

                case "2":
                    System.out.println("Informe o 1º nº");
                    numero1 = sc.nextDouble();
                    System.out.println("Informe o 2º nº");
                    numero2 = sc.nextDouble();
                    resultado = subltiplicação(numero1, numero2);
                    System.out.println("O resultado é " + resultado);

                case "3":
                    System.out.println("Informe o 1º nº");
                    numero1 = sc.nextDouble();
                    System.out.println("Informe o 2º nº");
                    numero2 = sc.nextDouble();
                    resultado = multiplicação(numero1, numero2);
                    System.out.println("O resultado é " + resultado);
                    break;

                case "4":
                    System.out.println("Informe o 1º nº");
                    numero1 = sc.nextDouble();
                    System.out.println("Informe o 2º nº");
                    numero2 = sc.nextDouble();
                    if (numero2 == 0) {
                        System.out.println("Não Dividíra por 0");
                    } else {
                        resultado = divisão(numero1, numero2);
                        System.out.println("O resultado é " + resultado);
                    }
                    break;

                case "5":
                    continuar = false;
                    System.out.println("Saindo...");
                    System.out.println("O resultado é " + resultado);
                    break;

                default:
                    System.out.println("Escolha uma Operação válida ");
                    break;
            }
        } while (continuar);
        sc.close();
    }
}
