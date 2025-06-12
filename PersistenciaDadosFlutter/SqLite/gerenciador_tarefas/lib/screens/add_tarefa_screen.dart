import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gerenciador_tarefas/controllers/tarefas_controller.dart';
import 'package:gerenciador_tarefas/models/tarefa_model.dart';
import 'package:gerenciador_tarefas/screens/lista_detalhe_screen.dart';

class AddTarefaScreen extends StatefulWidget {
  final int listaId; // recebe o id da lista/projeto da tela anterior

  AddTarefaScreen({super.key, required this.listaId});

  @override
  State<AddTarefaScreen> createState() => _AddTarefaScreenState();
}

class _AddTarefaScreenState extends State<AddTarefaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TarefasController _controllerTarefa = TarefasController();

  String prioridade = "";
  String descricao = "";
  DateTime _selectedDate = DateTime.now();

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _salvarTarefa() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newTarefa = Tarefa(
        listaId: widget.listaId,
        dataHora: _selectedDate,
        prioridade: prioridade,
        descricao: descricao.isEmpty ? "." : descricao,
      );

      try {
        await _controllerTarefa.adicionarTarefa(newTarefa);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Tarefa adicionada com sucesso!")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ListaDetalheScreen(listaId: widget.listaId),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao adicionar tarefa: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dataFormatada = DateFormat("dd/MM/yyyy");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova Tarefa"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Prioridade"),
                validator: (value) => value!.isEmpty ? "Por favor, insira a prioridade" : null,
                onSaved: (value) => prioridade = value!,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: Text("Data de vencimento: ${dataFormatada.format(_selectedDate)}")),
                  TextButton(
                    onPressed: () => _selecionarData(context),
                    child: const Text("Selecionar Data"),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: "Descrição"),
                maxLines: 3,
                onSaved: (value) => descricao = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarTarefa,
                child: const Text("Adicionar Tarefa"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}