import 'package:flutter/material.dart';

class Principalpage extends StatelessWidget{
  const Principalpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            Container(
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
          child: const Text("CRIAR SENHAS" ),),
           
            ),
            Container(
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
          child: const Text("ARMAZENAR SENHAS"),) ,
            )
            
          ],
        ),
      ),
    );
  }


}