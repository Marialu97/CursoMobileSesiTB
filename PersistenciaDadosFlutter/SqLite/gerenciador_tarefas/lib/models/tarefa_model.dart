import 'package:intl/intl.dart';

class Tarefa {
  final int? id; // ID será gerado pelo banco
  final int listaId; // chave estrangeira para a lista/projeto
  final String titulo;
  final String? descricao;
  final DateTime? dataVencimento;
  final String? prioridade; // pode ser: Alta, Média, Baixa
  final String? status;     // pode ser: Pendente, Em andamento, Concluída

  Tarefa({
    this.id,
    required this.listaId,
    required this.titulo,
    this.descricao,
    this.dataVencimento,
    this.prioridade,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lista_id': listaId,
      'titulo': titulo,
      'descricao': descricao,
      'data_vencimento': dataVencimento?.toIso8601String(),
      'prioridade': prioridade,
      'status': status,
    };
  }

  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'] as int?,
      listaId: map['lista_id'] as int,
      titulo: map['titulo'] as String,
      descricao: map['descricao'] as String?,
      dataVencimento: map['data_vencimento'] != null
          ? DateTime.parse(map['data_vencimento'])
          : null,
      prioridade: map['prioridade'] as String?,
      status: map['status'] as String?,
    );
  }

  String get dataVencimentoFormatada {
    if (dataVencimento == null) return '';
    final formatter = DateFormat("dd/MM/yyyy");
    return formatter.format(dataVencimento!);
  }

  @override
  String toString() {
    return "Tarefa{id: $id, listaId: $listaId, titulo: $titulo, descricao: $descricao, dataVencimento: $dataVencimento, prioridade: $prioridade, status: $status}";
  }
}
