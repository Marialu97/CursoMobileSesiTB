public class App {
    public static void main(String[] args) throws Exception {
       Pessoas pessoa1 = new Pessoas ("Maria",  "1234567898", "19-987654321");
        System.out.println("Usuario Cadastrado");
        System.out.println("Nome:" +pessoa1 .getNome());
        System.out.println("Contato:" +pessoa1.getContato());
        pessoa1.setNome("Maria Silva");
        System.out.println(pessoa1.getContato());
        
       }
    }

