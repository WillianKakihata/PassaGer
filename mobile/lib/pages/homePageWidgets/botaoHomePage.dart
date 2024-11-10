import 'package:flutter/material.dart';
import 'package:mobile/pages/principalPageWidgets/principalPage.dart';

class Botaohomepage extends StatelessWidget{
  const Botaohomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: ElevatedButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Principalpage()),
            );
          }, 
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF259DF2),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(10.0),
            minimumSize: const Size(200, 50)
          ) ,
          child: const Text("ENTRAR"),),); 
  }

  
}