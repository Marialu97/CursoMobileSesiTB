import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  //widget build
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Exemplo Widget Exibição')),
        body: Center(
          child: Column(
            children: [
              Text("Um texto Qualquer",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2
                ),),
              Image.network("https://imgs.search.brave.com/d0msSPSy2QKfrF8DTzHJsM8sx3mpF0iVI8_z57lAZ88/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMtMDAuaWNvbmR1/Y2suY29tL2Fzc2V0/cy4wMC9mbHV0dGVy/LWljb24tMjA3eDI1/Ni1qanN2MTRkMi5w/bmc",
              width: 200,
              height: 200,
              fit: BoxFit.cover),//Image.network
              Image.asset("assets/img/image.png",
              width: 200,
              height: 200,
              fit: BoxFit.cover,),
              Icon(Icons.star,
              size: 100,
              color: Colors.amber,)
            ],
          )
        ),
      ),
    );
  }

}