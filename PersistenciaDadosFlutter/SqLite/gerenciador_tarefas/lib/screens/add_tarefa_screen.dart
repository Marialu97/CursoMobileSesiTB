import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gerenciador_tarefas/controllers/tarefas_controller.dart';
import 'package:gerenciador_tarefas/models/tarefa_model.dart';

class AddTarefaScreen extends StatefulWidget {
  final int listaId;

  const AddTarefaScreen({super.key, required this.listaId});

  @override
  State<AddTarefaScreen> createState() => _AddTarefaScreenState();
}

class _AddTarefaScreenState extends State<AddTarefaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TarefasController _tarefaController = TarefasController();

  late String _titulo;
  String _descricao = "";
  DateTime _dataVencimento = DateTime.now();
  String _prioridade = "Média";
  String _status = "Pendente";

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataVencimento,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _dataVencimento = picked;
      });
    }
  }

  Future<void> _salvarTarefa() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final novaTarefa = Tarefa(
        listaId: widget.listaId,
        titulo: _titulo,
        descricao: _descricao,
        dataVencimento: _dataVencimento,
        prioridade: _prioridade,
        status: _status,
      );

      try {
        await _tarefaController.adicionarTarefa(novaTarefa);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Tarefa adicionada com sucesso!")),
        );
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(title: const Text("Nova Tarefa")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Título da Tarefa"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório!" : null,
                onSaved: (value) => _titulo = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Descrição"),
                onSaved: (value) => _descricao = value ?? "",
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text("Data de Vencimento: ${formatter.format(_dataVencimento)}"),
                  ),
                  TextButton(
                    onPressed: () => _selecionarData(context),
                    child: const Text("Selecionar Data"),
                  ),
                ],
              ),

              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: "Status"),
                items: ["Pendente", "Em andamento", "Concluída"].map((String valor) {
                  return DropdownMenuItem<String>(
                    value: valor,
                    child: Text(valor),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _status = value!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarTarefa,
                child: const Text("Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}