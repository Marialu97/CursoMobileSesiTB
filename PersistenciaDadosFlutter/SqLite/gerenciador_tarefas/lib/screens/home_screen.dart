import 'package:flutter/material.dart';
import 'package:seu_app/controllers/listas_controller.dart'; // seu controlador de listas
import 'package:seu_app/models/lista_model.dart'; // seu modelo Lista
import 'package:seu_app/screens/add_lista_screen.dart';
import 'package:seu_app/screens/lista_detalhe_screen.dart';

class ListasScreen extends StatefulWidget {
  @override
  State<ListasScreen> createState() => _ListasScreenState();
}

class _ListasScreenState extends State<ListasScreen> {
  final ListasController _listasController = ListasController();

  List<Lista> _listas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadListas();
  }

  Future<void> _loadListas() async {
    setState(() {
      _isLoading = true;
      _listas = [];
    });
    try {
      _listas = await _listasController.fetchListas();
    } catch (erro) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $erro")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Minhas Listas")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _listas.length,
              itemBuilder: (context, index) {
                final lista = _listas[index];
                return ListTile(
                  title: Text(lista.nome),
                  subtitle: Text("Descrição ou outra info aqui"),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ListaDetalheScreen(listaId: lista.id!),
                    ),
                  ),
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
          _loadListas(); // recarrega depois de adicionar
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
