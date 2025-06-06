import 'package:flutter/material.dart';
import 'package:seu_app/screens/home_screen.dart'; // ajuste o nome do seu app aqui

void main() {
  runApp(MaterialApp(
    title: 'Gerenciador de Tarefas',
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
