import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas/controllers/listas_controller.dart';
import 'package:gerenciador_tarefas/models/lista_model.dart';

class AddListaScreen extends StatefulWidget {
  const AddListaScreen({super.key});

  @override
  State<AddListaScreen> createState() => _AddListaScreenState();
}

class _AddListaScreenState extends State<AddListaScreen> {
  final _formKey = GlobalKey<FormState>();
  final ListasController _controller = ListasController();

  String titulo = "";
  String descricao = "";

  Future<void> _salvarLista() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final novaLista = Lista(
        titulo: titulo,
        descricao: descricao,
      );

      try {
        await _controller.inserirLista(novaLista);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Lista criada com sucesso!")),
        );
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao criar lista: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nova Lista")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Nome da Lista"),
                validator: (value) =>
                    value!.isEmpty ? "Por favor, insira um nome" : null,
                onSaved: (value) => titulo = value!,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: "Descrição (opcional)"),
                maxLines: 3,
                onSaved: (value) => descricao = value ?? "",
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarLista,
                child: const Text("Criar Lista"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}