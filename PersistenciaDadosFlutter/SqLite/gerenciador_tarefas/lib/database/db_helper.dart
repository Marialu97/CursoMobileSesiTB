import 'dart:async';
import 'package:path/path.dart';
import 'package:seu_app/models/tarefa_model.dart';
import 'package:seu_app/models/lista_model.dart';
import 'package:sqflite/sqflite.dart';

class ListaTarefaDBHelper {
  static Database? _database;

  // Singleton
  static final ListaTarefaDBHelper _instance = ListaTarefaDBHelper._internal();
  ListaTarefaDBHelper._internal();
  factory ListaTarefaDBHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final _dbPath = await getDatabasesPath();
    final path = join(_dbPath, "listas_tarefas.db"); // Nome do novo banco

    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future<void> _onCreateDB(Database db, int version) async {
    // Cria a tabela 'listas'
    await db.execute('''
      CREATE TABLE IF NOT EXISTS listas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        descricao TEXT NOT NULL,
        categoria TEXT NOT NULL,
        cor TEXT NOT NULL
      )
    ''');
    print("Tabela 'listas' criada com sucesso");

    // Cria a tabela 'tarefas'
    await db.execute('''
      CREATE TABLE IF NOT EXISTS tarefas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        lista_id INTEGER NOT NULL,
        data_hora TEXT NOT NULL,
        prioridade TEXT NOT NULL,
        descricao TEXT NOT NULL,
        FOREIGN KEY (lista_id) REFERENCES listas(id) ON DELETE CASCADE
      )
    ''');
    print("Tabela 'tarefas' criada com sucesso");
  }

  // CRUD para Listas

  Future<int> insertLista(Lista lista) async {
    final db = await database;
    return await db.insert("listas", lista.toMap());
  }

  Future<List<Lista>> getListas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("listas");
    return maps.map((e) => Lista.fromMap(e)).toList();
  }

  Future<Lista?> getListaById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      "listas",
      where: "id = ?",
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Lista.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteLista(int id) async {
    final db = await database;
    return await db.delete("listas", where: "id = ?", whereArgs: [id]);
  }

  // CRUD para Tarefas

  Future<int> insertTarefa(Tarefa tarefa) async {
    final db = await database;
    return await db.insert("tarefas", tarefa.toMap());
  }

  Future<List<Tarefa>> getTarefasForLista(int listaId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      "tarefas",
      where: "lista_id = ?",
      whereArgs: [listaId],
      orderBy: "data_hora ASC",
    );
    return maps.map((e) => Tarefa.fromMap(e)).toList();
  }

  Future<int> deleteTarefa(int id) async {
    final db = await database;
    return await db.delete("tarefas", where: "id = ?", whereArgs: [id]);
  }
}
