import 'package:flutter/material.dart';
import 'package:mobile/pages/homePageWidgets/homePage.dart';

void main (){
  runApp(AppSenha());
}

class AppSenha extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    
    return  MaterialApp(
      title: 'PassGer',
      theme: ThemeData.light(),
      home: Homepage(),
    );
  }
  
}