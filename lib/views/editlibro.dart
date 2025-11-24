import 'package:flutter/material.dart';
import 'package:readi_app/models/ModeloLibro.dart';
import 'package:readi_app/providers/bookprovider.dart';

class EditLibro extends StatefulWidget {
  final Book? book;
  final String? bookId;

  const EditLibro({
    super.key,
    this.book,
    this.bookId,
  });

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
  void initState() {
    super.initState();

    // Si viene desde seguimiento cargar data
    if (widget.book != null) {
      titleCtrl.text = widget.book!.title;
      authorCtrl.text = widget.book!.author;
      totalCtrl.text = widget.book!.pagesTotal.toString();
      readCtrl.text = widget.book!.pagesRead.toString();
    }
  }

  String _autoStatus() {
    final total = int.tryParse(totalCtrl.text) ?? 0;
    final read = int.tryParse(readCtrl.text) ?? 0;

    if (read <= 0) return "Pendiente";
    if (read >= total) return "Finalizado";
    return "En progreso";
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.bookId != null;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(isEditing ? "Editar Libro" : "Agregar Libro"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(label: Text('Título')),
            ),

            const SizedBox(height: 12),
            TextField(
              controller: authorCtrl,
              decoration: const InputDecoration(label: Text('Autor')),
            ),

            const SizedBox(height: 12),
            TextField(
              controller: totalCtrl,
              decoration: const InputDecoration(label: Text('Páginas totales')),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 12),
            TextField(
              controller: readCtrl,
              decoration: const InputDecoration(label: Text('Páginas leídas')),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  
                  final book = Book(
                    title: titleCtrl.text,
                    author: authorCtrl.text,
                    image: "assets/welcome.png",
                    status: _autoStatus(),
                    pagesTotal: int.tryParse(totalCtrl.text) ?? 0,
                    pagesRead: int.tryParse(readCtrl.text) ?? 0,
                  );

                  if (isEditing) {
                    await provider.updateBook(
                      docId: widget.bookId!,
                      data: book.toMap(),
                    );
                  } else {
                    await provider.saveBook(book);
                  }

                  if (mounted) Navigator.pop(context);
                },

                child: Text(isEditing ? "Guardar cambios" : "Agregar libro"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

