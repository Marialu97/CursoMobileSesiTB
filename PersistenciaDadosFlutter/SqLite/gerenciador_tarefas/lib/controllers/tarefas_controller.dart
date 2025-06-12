import 'package:gerenciador_tarefas/database/db_helper.dart';
import 'package:gerenciador_tarefas/models/tarefa_model.dart';

class TarefasController {
  final ListaTarefaDBHelper _dbHelper = ListaTarefaDBHelper();

  // Busca todas as tarefas de uma lista específica
  Future<List<Tarefa>> buscarTarefasPorLista(int listaId) async {
    return await _dbHelper.getTarefasForLista(listaId);
  }

  // Adiciona uma nova tarefa
  Future<int> adicionarTarefa(Tarefa tarefa) async {
    return await _dbHelper.insertTarefa(tarefa);
  }

  // Remove uma tarefa pelo id
  Future<int> removerTarefa(int id) async {
    return await _dbHelper.deleteTarefa(id);
  }
}