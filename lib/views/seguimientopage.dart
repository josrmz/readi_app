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
      backgroundColor: const Color(0xFFFFF1F8),

      appBar: AppBar(
        title: const Text("Seguimiento"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFFF875AA),
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Container(
              width: 180,
              height: 240,
              decoration: BoxDecoration(
                color: const Color(0xFFFFC4DD),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.menu_book_rounded, size: 90, color: Colors.white),
            ),
            const SizedBox(height: 18),

            Text(
              book.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D2E46),
              ),
              textAlign: TextAlign.center,
            ),

            Text(
              book.author,
              style: const TextStyle(
                fontSize: 17,
                color: Color(0xFF7A7A7A),
              ),
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE3EE),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [

                  Text(
                    "Estado: ${book.status}",
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Páginas: ${book.pagesRead}/${book.pagesTotal}",
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 16),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 12,
                      backgroundColor: Colors.white,
                      valueColor: const AlwaysStoppedAnimation(Color(0xFFF875AA)),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF875AA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
                ),
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

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE04664),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
                ),
                onPressed: () async {
                  await BookProvider().deleteBook(bookId);
                  if (context.mounted) Navigator.pop(context);
                },
                child: const Text("Eliminar libro"),
              ),
            ),


          ],
        ),
      ),
    );
  }
}

