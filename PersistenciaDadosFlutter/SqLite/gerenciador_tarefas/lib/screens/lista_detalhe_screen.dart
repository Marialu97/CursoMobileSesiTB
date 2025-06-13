import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas/controllers/listas_controller.dart';
import 'package:gerenciador_tarefas/controllers/tarefas_controller.dart';
import 'package:gerenciador_tarefas/models/lista_model.dart';
import 'package:gerenciador_tarefas/models/tarefa_model.dart';
import 'package:gerenciador_tarefas/screens/add_tarefa_screen.dart';

class ListaDetalheScreen extends StatefulWidget {
  final int listaId;

  const ListaDetalheScreen({super.key, required this.listaId});

  @override
  State<ListaDetalheScreen> createState() => _ListaDetalheScreenState();
}

class _ListaDetalheScreenState extends State<ListaDetalheScreen> {
  final ListasController _listasController = ListasController();
  final TarefasController _tarefasController = TarefasController();

  Lista? _lista;
  List<Tarefa> _tarefas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDados();
  }

  Future<void> _loadDados() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _lista = await _listasController.buscarListaPorId(widget.listaId);
      _tarefas = await _tarefasController.buscarTarefasDaLista(widget.listaId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar lista/tarefas: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _deletarTarefa(int tarefaId) async {
    try {
      await _tarefasController.deletarTarefa(tarefaId);
      await _loadDados();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tarefa removida com sucesso")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao deletar tarefa: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes da Lista"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _lista == null
              ? const Center(child: Text("Erro ao carregar a lista"))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nome: ${_lista!.titulo}", style: const TextStyle(fontSize: 20)),
                      Text("Descrição: ${_lista!.descricao ?? ''}"),
                      const Divider(),
                      const Text("Tarefas:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      _tarefas.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text("Nenhuma tarefa adicionada."),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: _tarefas.length,
                                itemBuilder: (context, index) {
                                  final tarefa = _tarefas[index];
                                  return Card(
                                    margin: const EdgeInsets.symmetric(vertical: 4),
                                    child: ListTile(
                                      title: Text(tarefa.titulo),
                                      subtitle: Text("${tarefa.descricao ?? ''}\n${tarefa.dataVencimentoFormatada}"),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _deletarTarefa(tarefa.id!),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTarefaScreen(listaId: widget.listaId)),
          );
          _loadDados(); // recarrega ao voltar
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}