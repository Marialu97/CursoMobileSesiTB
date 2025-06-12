import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas/screens/home_screen.dart';
import ''; // ajuste o nome do seu app aqui

void main() {
  runApp(MaterialApp(
    title: 'Gerenciador de Tarefas',
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
