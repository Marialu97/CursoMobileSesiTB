import 'package:gerenciador_tarefas/data/database/db_helper.dart';
import 'package:gerenciador_tarefas/data/models/tarefa_model.dart';

class ListasController {
  final ListaTarefaDBHelper _dbHelper = ListaTarefaDBHelper();

  // Pega as tarefas de uma lista específica
  Future<List<Tarefa>> getTarefasByLista(int listaId) async {
    return await _dbHelper.getTarefasForLista(listaId);
  }

  // Insere uma nova tarefa
  Future<int> insertTarefa(Tarefa tarefa) async {
    return await _dbHelper.insertTarefa(tarefa);
  }

  // Deleta uma tarefa pelo id
  Future<int> deleteTarefa(int id) async {
    return await _dbHelper.deleteTarefa(id);
  }
}