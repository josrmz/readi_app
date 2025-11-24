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
      backgroundColor: const Color(0xFFFFF1F8),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFFF875AA),
        foregroundColor: Colors.white,
        title: Text(isEditing ? "Editar Libro" : "Agregar Libro"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 12),

            _field("Título", titleCtrl),
            _field("Autor", authorCtrl),
            _field("Páginas totales", totalCtrl, number: true),
            _field("Páginas leídas", readCtrl, number: true),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF875AA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

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

                child: Text(
                  isEditing ? "Guardar cambios" : "Agregar libro",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _field(String label, TextEditingController c, {bool number = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextField(
        controller: c,
        keyboardType: number ? TextInputType.number : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF7A7A7A),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFFFFC4DD),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFFF875AA),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}


