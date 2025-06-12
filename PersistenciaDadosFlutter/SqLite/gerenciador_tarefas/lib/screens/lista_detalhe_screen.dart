import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas/controllers/listas_controller.dart';
import 'package:gerenciador_tarefas/controllers/tarefas_controller.dart';
import 'package:gerenciador_tarefas/models/lista_model.dart';
import 'package:gerenciador_tarefas/models/tarefa_model.dart';
import 'package:gerenciador_tarefas/screens/add_tarefa_screen.dart';

class ListaDetalheScreen extends StatefulWidget {
  final int listaId;

  const ListaDetalheScreen({
    super.key,
    required this.listaId,
  });

  @override
  State<StatefulWidget> createState() {
    return _ListaDetalheScreenState();
  }
}

class _ListaDetalheScreenState extends State<ListaDetalheScreen> {
  final ListasController _controllerListas = ListasController();
  final TarefasController _controllerTarefas = TarefasController();
  bool _isLoading = true;

  Lista? _lista;
  List<Tarefa> _tarefas = [];

  @override
  void initState() {
    super.initState();
    _loadListaTarefas();
  }

  Future<void> _loadListaTarefas() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _lista = await _controllerListas.buscarListaPorId(widget.listaId);
      _tarefas = await _controllerTarefas.buscarTarefasPorLista(widget.listaId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro: $e")));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _deleteTarefa(int tarefaId) async {
    try {
      await _controllerTarefas.removerTarefa(tarefaId);
      await _loadListaTarefas();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tarefa deletada com sucesso!")),
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
              ? const Center(child: Text("Erro ao carregar a lista. Verifique o ID."))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nome: ${_lista!.nome}", style: const TextStyle(fontSize: 20)),
                      Text("Descrição: ${_lista!.descricao}"),
                      const Divider(),
                      const Text("Tarefas:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      _tarefas.isEmpty
                          ? const Center(child: Text("Não existem tarefas cadastradas para esta lista."))
                          : Expanded(
                              child: ListView.builder(
                                itemCount: _tarefas.length,
                                itemBuilder: (context, index) {
                                  final tarefa = _tarefas[index];
                                  return Card(
                                    margin: const EdgeInsets.symmetric(vertical: 4),
                                    child: ListTile(
                                      title: Text(tarefa.descricao),
                                      subtitle: Text(
                                        "Prioridade: ${tarefa.prioridade}\nVencimento: ${tarefa.dataHoraFormatada}",
                                      ),
                                      trailing: IconButton(
                                        onPressed: () => _deleteTarefa(tarefa.id!),
                                        icon: const Icon(Icons.delete, color: Colors.red),
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
            MaterialPageRoute(
              builder: (context) => AddTarefaScreen(listaId: widget.listaId),
            ),
          );
          _loadListaTarefas();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}