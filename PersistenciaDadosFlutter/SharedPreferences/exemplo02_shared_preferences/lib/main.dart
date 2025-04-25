import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário Simples',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _name = '';
  String _age = '';
  String _favoriteColor = 'Red'; // Cor padrão

  // Função para salvar os dados usando shared_preferences
  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('age', _ageController.text);
    await prefs.setString('favoriteColor', _favoriteColor);

    _loadData(); // Carregar dados após salvar
  }

  // Função para carregar os dados
  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? '';
      _age = prefs.getString('age') ?? '';
      _favoriteColor = prefs.getString('favoriteColor') ?? 'Red';
    });
  }

  // Função para obter a cor a partir do nome da cor
  Color _getColorFromString(String colorString) {
    switch (colorString) {
      case 'Red':
        return Colors.red;
      case 'Green':
        return Colors.green;
      case 'Blue':
        return Colors.blue;
      case 'Yellow':
        return Colors.yellow;
      case 'Orange':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData(); // Carregar dados quando o app iniciar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário Simples'),
      ),
      body: Container(
        color: _getColorFromString(_favoriteColor), // Muda o fundo com base na cor favorita
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Idade'),
            ),
            DropdownButton<String>(
              value: _favoriteColor,
              onChanged: (String? newValue) {
                setState(() {
                  _favoriteColor = newValue!;
                });
              },
              items: <String>['Red', 'Green', 'Blue', 'Yellow', 'Orange']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveData,
              child: Text('Salvar Dados'),
            ),
            SizedBox(height: 20),
            Text('Dados Salvos:'),
            Text('Nome: $_name'),
            Text('Idade: $_age'),
            Text('Cor Favorita: $_favoriteColor'),
          ],
        ),
      ),
    );
  }
}
