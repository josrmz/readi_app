import 'package:flutter/material.dart';
import 'package:readi_app/models/ModeloLibro.dart';
import 'package:readi_app/providers/bookprovider.dart';

class EditLibro extends StatefulWidget {
  const EditLibro({super.key});

  @override
  State<EditLibro> createState() => _EditLibroState();
}

class _EditLibroState extends State<EditLibro> {
  final titleCtrl = TextEditingController();
  final authorCtrl = TextEditingController();
  final totalCtrl = TextEditingController();
  final readCtrl = TextEditingController();

  final provider = BookProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Libro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                label: Text('Título'),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: authorCtrl,
              decoration: const InputDecoration(
                label: Text('Autor'),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: totalCtrl,
              decoration: const InputDecoration(
                label: Text('Páginas totales'),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: readCtrl,
              decoration: const InputDecoration(
                label: Text('Páginas leídas'),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {

                  final book = Book(
                    title: titleCtrl.text,
                    author: authorCtrl.text,
                    status: "Pendiente",
                    image: "assets/welcome.png",
                    pagesTotal: int.tryParse(totalCtrl.text) ?? 0,
                    pagesRead: int.tryParse(readCtrl.text) ?? 0,
                  );

                  await provider.saveBook(book);

                  Navigator.pop(context);
                },
                child: const Text('Guardar Cambios'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
