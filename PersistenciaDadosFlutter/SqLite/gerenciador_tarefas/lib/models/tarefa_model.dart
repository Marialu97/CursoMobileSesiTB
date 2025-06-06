import 'package:intl/intl.dart';

class Tarefa {
  final int? id; // ID gerado pelo BD
  final int listaId; // Chave Estrangeira para a Lista/Projeto
  final DateTime dataHora; // Data de vencimento
  final String prioridade; // Ex: Alta, Média, Baixa
  final String descricao; // Detalhes da tarefa

  // CONSTRUTOR
  Tarefa({
    this.id,
    required this.listaId,
    required this.dataHora,
    required this.prioridade,
    required this.descricao,
  });

  // Converter Map: Obj => BD
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "lista_id": listaId,
      "data_hora": dataHora.toIso8601String(),
      "prioridade": prioridade,
      "descricao": descricao,
    };
  }

  // Converte Map: BD => Obj
  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map["id"] as int,
      listaId: map["lista_id"] as int,
      dataHora: DateTime.parse(map["data_hora"] as String),
      prioridade: map["prioridade"] as String,
      descricao: map["descricao"] as String,
    );
  }

  // Formatação de data e hora no formato regional
  String get dataHoraFormatada {
    final formatter = DateFormat("dd/MM/yyyy HH:mm");
    return formatter.format(dataHora);
  }

  @override
  String toString() {
    return "Tarefa{id: $id, listaId: $listaId, dataHora: $dataHora, prioridade: $prioridade, descricao: $descricao}";
  }
}
