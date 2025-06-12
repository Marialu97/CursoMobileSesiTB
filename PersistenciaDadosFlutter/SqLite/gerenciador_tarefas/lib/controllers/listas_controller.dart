import 'package:gerenciador_tarefas/database/db_helper.dart';
import 'package:gerenciador_tarefas/models/lista_model.dart';

class ListasController {
  final ListaTarefaDBHelper _dbHelper = ListaTarefaDBHelper();

  // Busca todas as listas
  Future<List<Lista>> buscarListas() async {
    return await _dbHelper.getListas();
  }

  // Busca uma lista pelo id
  Future<Lista?> buscarListaPorId(int id) async {
    return await _dbHelper.getListaById(id);
  }

  // Insere uma nova lista
  Future<int> inserirLista(Lista lista) async {
    return await _dbHelper.insertLista(lista);
  }

  // Deleta uma lista pelo id
  Future<int> deletarLista(int id) async {
    return await _dbHelper.deleteLista(id);
  }
}