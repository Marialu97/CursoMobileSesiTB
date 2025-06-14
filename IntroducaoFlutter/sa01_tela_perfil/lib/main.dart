import 'package:flutter/material.dart';
 
// void Main
void main() {
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //estudo do scaffold
      home: Scaffold(
        //barra de navegação superior
        appBar: AppBar(
          backgroundColor: Colors.blue,
        ),
        //Corpo do aplicativo
        body:Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipOval(
                        child: Container(
                        width: 200,
                        height: 200,
                        color: const Color.fromARGB(255, 54, 73, 244),
                      ),
                      ),
                      Image.asset("assets/img/image.png",
                      width: 200,
                      height: 200,)
                    ],
                  ),
                  ],
                  ),
                  Column(
  children: [ 
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) => Icon(Icons.star, color: Colors.amber, size: 30)),
        ),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Maria Luiza",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    ),
   
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Limeira-SP",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    ),
  ],
),
                   Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Container(
                     width: 160,
                     height: 160,
                     color: Colors.blue,
                  ),
                  Container(
                     width: 160,
                     height: 160,
                     color: Colors.blue,
                  ),
                  Container(
                    width: 160,
                    height: 160,
                    color: Colors.blue,
        ),
      ],
    ),
                  Text(""),
                  Text(""),
                  Text(""),
              ],
          ),
        ) ,
        //barra lateral (menu hamburguer)
        drawer: Drawer(
          child: ListView(
            children: [Text("Inicio"), Text("Conteudo"), Text("Contato")],
          ),
        ),
        //barra de navegação inferior
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notificação"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: "Shopping"),   
          ],
        ),
        //botão flutuante
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("Botão Clicado");
          },
          child: Icon(Icons.person_sharp),
        ),
      ),
    );
  }
}