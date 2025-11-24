import 'package:flutter/material.dart';
import 'package:readi_app/views/homepage.dart';
import 'package:readi_app/views/welcomepage.dart';
import 'constants.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      title: 'Readi App',
      theme : ThemeData(
      primaryColor : kPrimaryColor,
       scaffoldBackgroundColor : Colors.white,),
      home : WelcomePage(),
    ); 

  }
  
}
