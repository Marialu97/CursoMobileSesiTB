import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas/controllers/listas_controller.dart';
import 'package:gerenciador_tarefas/models/lista_model.dart';
import 'package:gerenciador_tarefas/screens/lista_detalhe_screen.dart';
import 'package:gerenciador_tarefas/screens/add_lista_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ListasController _listasController = ListasController();
  List<Lista> _listas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadListas();
  }

  Future<void> _loadListas() async {
    setState(() => _isLoading = true);
    try {
      _listas = await _listasController.buscarListas();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar listas: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Minhas Listas")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _listas.isEmpty
              ? const Center(child: Text("Nenhuma lista cadastrada."))
              : ListView.builder(
                  itemCount: _listas.length,
                  itemBuilder: (context, index) {
                    final lista = _listas[index];
                    return ListTile(
                      title: Text(lista.titulo),
                      subtitle: Text(lista.descricao ?? ''),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListaDetalheScreen(listaId: lista.id!),
                          ),
                        );
                        _loadListas();
                      },
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Adicionar Nova Lista",
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddListaScreen()),
          );
          _loadListas();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}