import 'dart:async';
import 'package:path/path.dart';
import 'package:gerenciador_tarefas/models/tarefa_model.dart';
import 'package:gerenciador_tarefas/models/lista_model.dart';
import 'package:sqflite/sqflite.dart';

class ListaTarefasDBHelper {
  static Database? _database;
  static final ListaTarefasDBHelper _instance = ListaTarefasDBHelper._internal();

  ListaTarefasDBHelper._internal();

  factory ListaTarefasDBHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final _dbPath = await getDatabasesPath();
    final path = join(_dbPath, "listas_tarefas.db");
    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future<void> _onCreateDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS listas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        descricao TEXT
      )
    ''');
    print("Tabela listas criada");

    await db.execute('''
      CREATE TABLE IF NOT EXISTS tarefas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        lista_id INTEGER NOT NULL,
        titulo TEXT NOT NULL,
        descricao TEXT,
        data_vencimento TEXT,
        prioridade TEXT,
        status TEXT,
        FOREIGN KEY (lista_id) REFERENCES listas(id) ON DELETE CASCADE
      )
    ''');
    print("Tabela tarefas criada");
  }

  Future<int> inserirLista(Lista lista) async {
    final db = await database;
    return await db.insert("listas", lista.toMap());
  }

  Future<List<Lista>> buscarListas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("listas");
    return maps.map((e) => Lista.fromMap(e)).toList();
  }

  Future<Lista?> buscarListaPorId(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("listas", where: "id=?", whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Lista.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deletarLista(int id) async {
    final db = await database;
    return await db.delete("listas", where: "id=?", whereArgs: [id]);
  }

  Future<int> inserirTarefa(Tarefa tarefa) async {
    final db = await database;
    return await db.insert("tarefas", tarefa.toMap());
  }

  Future<List<Tarefa>> buscarTarefasPorLista(int listaId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      "tarefas",
      where: "lista_id = ?",
      whereArgs: [listaId],
      orderBy: "data_vencimento ASC",
    );
    return maps.map((e) => Tarefa.fromMap(e)).toList();
  }

  Future<Tarefa?> buscarTarefaPorId(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("tarefas", where: "id=?", whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Tarefa.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deletarTarefa(int id) async {
    final db = await database;
    return await db.delete("tarefas", where: "id=?", whereArgs: [id]);
  }

  Future<int> atualizarTarefa(Tarefa tarefa) async {
    final db = await database;
    return await db.update(
      "tarefas",
      tarefa.toMap(),
      where: "id=?",
      whereArgs: [tarefa.id],
    );
  }
}