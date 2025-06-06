import 'package:flutter/material.dart';
import 'package:sa_petshop/controllers/tarefas_controller.dart';
import 'package:sa_petshop/models/tarefa_model.dart';
import 'package:sa_petshop/screens/home_screen.dart';

class AddTarefaScreen extends StatefulWidget {
  final int listaId; // id da lista/projeto ao qual a tarefa pertence

  AddTarefaScreen({Key? key, required this.listaId}) : super(key: key);

  @override
  State<AddTarefaScreen> createState() => _AddTarefaScreenState();
}

class _AddTarefaScreenState extends State<AddTarefaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tarefasController = TarefasController();

  late String _titulo;
  String _descricao = "";
  DateTime _dataVencimento = DateTime.now();
  String _prioridade = "Média";
  String _status = "Pendente";

  Future<void> _salvarTarefa() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newTarefa = Tarefa(
        listaId: widget.listaId,
        dataHora: _dataVencimento,
        prioridade: _prioridade,
        descricao: _descricao,
      );

      try {
        await _tarefasController.addTarefa(newTarefa);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Tarefa adicionada com sucesso!")),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao adicionar tarefa: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nova Tarefa")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Título da Tarefa"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
                onSaved: (value) => _titulo = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Descrição"),
                maxLines: 3,
                onSaved: (value) => _descricao = value ?? "",
              ),
              // Aqui você pode adicionar campos para data, prioridade e status conforme necessidade
              ElevatedButton(onPressed: _salvarTarefa, child: Text("Salvar Tarefa")),
            ],
          ),
        ),
      ),
    );
  }
}