import 'package:flutter/material.dart';
import 'package:readi_app/views/editlibro.dart';
import 'package:readi_app/widgets/infolibro.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Libros'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(148, 163, 55, 115),
              ),
              child: Text('Menu'),
            ),
          ],
        ),
      ),
      body: const InfoLibro(),
      floatingActionButton: Transform.scale(
        scale: 1.5,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const EditLibro())
            );
            // Aqui debera ir la logica para subir a la base de firebase
          },
          child: const Icon(Icons.add, size: 36),
        ), 
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}