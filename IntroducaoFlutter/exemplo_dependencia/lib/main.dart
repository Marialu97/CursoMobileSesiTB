import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main(){ // metodo principal para rodar aplicação
  runApp(MyApp()); //construtor da classe principal
}

class MyApp extends StatelessWidget{ // classe principal
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(// MaterialApp - contem as widgets Android
    home: Scaffold( // Tela de visualização basica
      appBar: AppBar(
        title: Text("Exemplo App Dependência"),
      ),
      body: Center(
        child: ElevatedButton(onPressed: (){
          Fluttertoast.showToast(
            msg: "Olá, Mundo!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER);
        },
         child: Text("Clique Aqui!")),
      ),

    ),
   );
  }
}