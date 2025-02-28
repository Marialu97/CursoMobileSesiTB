public abstract class Pessoas {
   //atribitos
    String nome;
    String cof;
    String contato;

    //contrutor
    public Pessoas(String nome, String cof, String contato) {
        this.nome = nome;
        this.cof = cof;
        this.contato = contato;
    }
      //métodos
    // getters - leitura de informacao 

    public String getNome() {
        return nome;
    }

    public String getCof() {
        return cof;
    }

    public String getContato() {
        return contato;
    }

       //setters - alteram infromacao 

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setContato(String contato) {
        this.contato = contato;
    }
    

    

  



  

}
