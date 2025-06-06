import 'package:seu_app/data/database/db_helper.dart';
import '../models/lista_model.dart';

class ListasController {
  // conexão com o banco de dados
  final ListaTarefaDBHelper _dbHelper = ListaTarefaDBHelper();

  Future<int> addLista(Lista lista) async {
    return await _dbHelper.insertLista(lista);
  }

  Future<List<Lista>> fetchListas() async {
    return await _dbHelper.getListas();
  }

  Future<Lista?> findListaById(int id) async {
    return await _dbHelper.getListaById(id);
  }

  Future<int> deleteLista(int id) async {
    return await _dbHelper.deleteLista(id);
  }
}
