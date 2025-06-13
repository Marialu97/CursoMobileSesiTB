import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas/screens/home_screen.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Gerenciador de Tarefas',
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}