import 'package:flutter/material.dart';
import 'package:mobile/pages/homePageWidgets/botaoHomePage.dart';

class Homepage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      body: Center( child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('BEM - VINDO AO PASSAGER', style: TextStyle(fontSize: 40.0, color: Color(0xFF259DF2)),), 
          Botaohomepage(),
        ],
      ),),
    );
  }

}