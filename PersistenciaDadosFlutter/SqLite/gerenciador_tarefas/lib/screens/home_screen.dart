import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas/controllers/listas_controller.dart';
import 'package:gerenciador_tarefas/models/lista_model.dart';
import 'package:gerenciador_tarefas/screens/lista_detalhe_screen.dart';
import 'package:gerenciador_tarefas/screens/add_lista_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ListasController _controller = ListasController();
  List<Lista> _listas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadListas();
  }

  Future<void> _loadListas() async {
    setState(() => _isLoading = true);
    _listas = await _controller.buscarListas();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Listas/Projetos")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _listas.isEmpty
              ? const Center(child: Text("Nenhuma lista cadastrada."))
              : ListView.builder(
                  itemCount: _listas.length,
                  itemBuilder: (context, index) {
                    final lista = _listas[index];
                    return ListTile(
                      title: Text(lista.nome),
                      subtitle: Text(lista.descricao),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListaDetalheScreen(listaId: lista.id!),
                        ),
                      ).then((_) => _loadListas()),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddListaScreen()),
          );
          if (result == true) _loadListas();
        },
        child: const Icon(Icons.add),
        tooltip: "Adicionar Lista",
      ),
    );
  }
}