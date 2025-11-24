import 'package:flutter/material.dart';
import 'package:readi_app/models/ModeloLibro.dart';
import 'package:readi_app/providers/bookprovider.dart';
import 'package:readi_app/views/seguimientopage.dart';
import 'editlibro.dart';

class SeguimientoPage extends StatelessWidget {
  final Book book;
  final String bookId;

  const SeguimientoPage({
    super.key,
    required this.book,
    required this.bookId,
  });

  @override
  Widget build(BuildContext context) {

    final progress = book.pagesTotal == 0
        ? 0.0
        : (book.pagesRead / book.pagesTotal);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Seguimiento"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            /// Imagen portada
            Container(
              width: 180,
              height: 240,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 18),

            Text(
              book.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            Text(
              book.author,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            Text(
              "Estado: ${book.status}",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 12),

            Text(
              "Páginas leídas: ${book.pagesRead}/${book.pagesTotal}",
              style: const TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 15),

            LinearProgressIndicator(
              value: progress,
              minHeight: 12,
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditLibro(
                        book: book,
                        bookId: bookId,
                      ),
                    ),
                  );
                },
                child: const Text("Editar libro"),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                onPressed: () async {
                  await BookProvider().deleteBook(bookId);
                  if (context.mounted) Navigator.pop(context);
                },
                child: const Text("Eliminar libro"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
