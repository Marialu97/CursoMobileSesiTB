import 'package:gerenciador_tarefas/database/db_helper.dart';
import 'package:gerenciador_tarefas/models/lista_model.dart';

class ListasController {
  final ListaTarefasDBHelper _dbHelper = ListaTarefasDBHelper();

  Future<List<Lista>> buscarListas() async {
    return await _dbHelper.buscarListas();
  }

  Future<Lista?> buscarListaPorId(int id) async {
    return await _dbHelper.buscarListaPorId(id);
  }

  Future<int> inserirLista(Lista lista) async {
    return await _dbHelper.inserirLista(lista);
  }

  Future<int> deletarLista(int id) async {
    return await _dbHelper.deletarLista(id);
  }
}