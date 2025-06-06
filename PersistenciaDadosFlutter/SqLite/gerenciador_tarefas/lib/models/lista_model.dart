class Lista {
  final int? id; // ID gerado pelo BD, pode ser null na criação
  final String nome; // Nome da lista ou projeto
  final String descricao; // Descrição do projeto/lista
  final String categoria; // Ex: Trabalho, Pessoal, Compras, etc.
  final String cor; // Cor ou etiqueta visual (opcional)

  // Construtor
  Lista({
    this.id,
    required this.nome,
    required this.descricao,
    required this.categoria,
    required this.cor,
  });

  // Converter um objeto em Map (para inserir no BD)
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nome": nome,
      "descricao": descricao,
      "categoria": categoria,
      "cor": cor,
    };
  }

  // Criar um objeto a partir de um Map (ler do BD)
  factory Lista.fromMap(Map<String, dynamic> map) {
    return Lista(
      id: map["id"] as int,
      nome: map["nome"] as String,
      descricao: map["descricao"] as String,
      categoria: map["categoria"] as String,
      cor: map["cor"] as String,
    );
  }

  @override
  String toString() {
    return "Lista{id: $id, nome: $nome, descrição: $descricao, categoria: $categoria, cor: $cor}";
  }
}
