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

  String nome = "";
  String descricao = "";
  String categoria = "";
  String cor = "";

  Future<void> _salvarLista() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final novaLista = Lista(
        nome: nome,
        descricao: descricao,
        categoria: categoria,
        cor: cor,
      );

      try {
        await _controller.inserirLista(novaLista);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Lista adicionada com sucesso!")),
        );
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao adicionar lista: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nova Lista/Projeto")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Nome"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => nome = value!,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: "Descrição"),
                onSaved: (value) => descricao = value ?? "",
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: "Categoria"),
                onSaved: (value) => categoria = value ?? "",
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: "Cor"),
                onSaved: (value) => cor = value ?? "",
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarLista,
                child: const Text("Adicionar Lista"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}