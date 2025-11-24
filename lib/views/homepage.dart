import 'package:flutter/material.dart';
import 'package:readi_app/views/editlibro.dart';
import 'package:readi_app/widgets/infolibro.dart';
import 'package:readi_app/views/welcomepage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF1F8), // fondo suave rosa pastel

      appBar: AppBar(
        centerTitle: true, 
        title: const Text('READi - Tus Libros'),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF875AA),
                    Color(0xFFC084FC),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text('Menú', style: TextStyle(color: Colors.white)),
            ),

            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFFF875AA)),
              title: const Text("Cerrar sesión"),

              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      body: const InfoLibro(),

      floatingActionButton: Transform.scale(
        scale: 1.4,
        child: FloatingActionButton(
          backgroundColor: const Color(0xFFF875AA),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const EditLibro(),
              ),
            );
          },
          child: const Icon(Icons.add, size: 36, color: Colors.white),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

