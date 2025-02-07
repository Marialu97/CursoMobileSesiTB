public class Aluno extends Pessoas{

    //atributos
    String curso;
    int rm;

    public Aluno(String nome, String cof, String contato, String curso, int rm) {
      super(nome, cof, contato);
      this.curso = curso;
      this.rm = rm;
   }

    //métodos
    public String euSouAluno(){
       return "Aluno" + rm;
    }
}

