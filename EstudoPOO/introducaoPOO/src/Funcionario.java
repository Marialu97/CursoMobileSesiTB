public class Funcionario extends Pessoas{

    //atributo
    String Cargo;
    String nif;

    //construtor 
    public Funcionario(
        String nome,
         String cof, 
         String contato,
         String Cargo,
         String nif) {
        super(nome, cof, contato);
        this.Cargo = Cargo;
        this.nif = nif;
    }

    //métodos
    public String euSouFuncionario() {
        return "Funcionario" +nif;
    }

}
