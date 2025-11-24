
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:readi_app/firebase_options.dart';
import 'package:readi_app/views/homepage.dart';
import 'package:readi_app/views/welcomepage.dart';
import 'package:readi_app/views/loginpage.dart';
import 'package:readi_app/views/signup.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      
      initialRoute: '/welcome',
      
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const HomePage()
      },//HomePage(),

    ); 
    
  }
  
}
