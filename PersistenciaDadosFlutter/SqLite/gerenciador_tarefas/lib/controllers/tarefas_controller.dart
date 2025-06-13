import 'package:gerenciador_tarefas/database/db_helper.dart';
import 'package:gerenciador_tarefas/models/tarefa_model.dart';

class TarefasController {
  final ListaTarefasDBHelper _dbHelper = ListaTarefasDBHelper();

  Future<int> adicionarTarefa(Tarefa tarefa) async {
    return await _dbHelper.inserirTarefa(tarefa);
  }

  Future<List<Tarefa>> buscarTarefasDaLista(int listaId) async {
    return await _dbHelper.buscarTarefasPorLista(listaId);
  }

  Future<Tarefa?> buscarTarefaPorId(int id) async {
    return await _dbHelper.buscarTarefaPorId(id);
  }

  Future<int> deletarTarefa(int id) async {
    return await _dbHelper.deletarTarefa(id);
  }

  Future<int> atualizarTarefa(Tarefa tarefa) async {
    return await _dbHelper.atualizarTarefa(tarefa);
  }
}
