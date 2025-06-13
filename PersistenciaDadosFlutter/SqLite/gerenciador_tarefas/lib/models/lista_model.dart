class Lista {
  final int? id; // ID gerado automaticamente pelo banco
  final String titulo;
  final String? descricao; // opcional

  Lista({
    this.id,
    required this.titulo,
    this.descricao,
  });

  // Converte o objeto para um Map (para salvar no banco)
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "titulo": titulo,
      "descricao": descricao,
    };
  }

  // Converte o Map (lido do banco) para objeto Lista
  factory Lista.fromMap(Map<String, dynamic> map) {
    return Lista(
      id: map["id"] as int,
      titulo: map["titulo"] as String,
      descricao: map["descricao"] as String?,
    );
  }

  @override
  String toString() {
    return "Lista{id: $id, título: $titulo, descrição: $descricao}";
  }
}
