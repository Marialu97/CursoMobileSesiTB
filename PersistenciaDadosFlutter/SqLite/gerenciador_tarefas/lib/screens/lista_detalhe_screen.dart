import 'package:flutter/material.dart';
import 'package:seu_app/controllers/consultas_controller.dart'; // ou o equivalente para itens da lista
import 'package:seu_app/controllers/listas_controller.dart';
import 'package:seu_app/models/consulta_model.dart'; // ou outro modelo se não usar consultas
import 'package:seu_app/models/lista_model.dart';
import 'package:seu_app/screens/add_consulta_screen.dart'; // ou add_item_lista_screen.dart

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
  final ConsultasController _controllerConsultas = ConsultasController();
  bool _isLoading = true;

  Lista? _lista;
  List<Consulta> _consultas = []; // adapte para itens que quiser mostrar na lista

  @override
  void initState() {
    super.initState();
    _loadListaConsultas();
  }

  Future<void> _loadListaConsultas() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _lista = await _controllerListas.findListaById(widget.listaId);
      _consultas = await _controllerConsultas.getConsultasByPet(widget.listaId);
      // adapte essa linha para pegar os itens relacionados à lista
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro: $e")));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _deleteConsulta(int consultaId) async {
    try {
      await _controllerConsultas.deleteConsulta(consultaId);
      await _loadListaConsultas();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Item deletado com sucesso!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao deletar item: $e")),
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
                      Text("Descrição: ${_lista!.descricao}"), // adapte para seus campos
                      const Divider(),
                      const Text("Itens:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      _consultas.isEmpty
                          ? const Center(child: Text("Não existem itens cadastrados para esta lista."))
                          : Expanded(
                              child: ListView.builder(
                                itemCount: _consultas.length,
                                itemBuilder: (context, index) {
                                  final consulta = _consultas[index];
                                  return Card(
                                    margin: const EdgeInsets.symmetric(vertical: 4),
                                    child: ListTile(
                                      title: Text(consulta.tipoServico),
                                      subtitle: Text(consulta.dataHoraFormata),
                                      trailing: IconButton(
                                        onPressed: () => _deleteConsulta(consulta.id!),
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
              builder: (context) => AddConsultaScreen(petId: widget.listaId),
              // adapte para AddItemListaScreen ou algo parecido
            ),
          );
          _loadListaConsultas();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
