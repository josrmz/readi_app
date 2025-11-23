
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body : SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                   "Bienvenido",
                   style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize : 30,
                ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Preparate para el reto de lectura",
                textAlign : TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 15,

                ),
                 )
                
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height/3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/welcome.png")
                  )
                ),
              ),

              Column(
                children: <Widget>[
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));


                    },

                  )
                ],
              )





            ],
          ),
        ),
        ),
    );
  }
}
