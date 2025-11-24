import 'package:flutter/material.dart';
import 'package:readi_app/models/ModeloLibro.dart';
import 'package:readi_app/providers/bookprovider.dart';
import 'package:readi_app/views/seguimientopage.dart';

class InfoLibro extends StatelessWidget {
  const InfoLibro({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = BookProvider();

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: provider.getBooksStreamWithIds(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFFE91E63)));
        }

        final books = snapshot.data ?? [];

        if (books.isEmpty) {
          return const Center(
            child: Text(
              "No hay libros añadidos aún",
              style: TextStyle(color: Color(0xFFE91E63), fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: books.length,
          itemBuilder: (context, index) {

            final data = books[index];
            final Book b = data["book"];
            final String id = data["id"];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SeguimientoPage(
                      book: b,
                      bookId: id,
                    ),
                  ),
                );
              },

              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1F7),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Color(0xFFF06292), width: 1.4),
                ),
                margin: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    
                    Container(
                      width: 70,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFFF06292),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            b.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Color(0xFFE91E63),
                            ),
                          ),
                          const SizedBox(height: 4),

                          Text("Autor: ${b.author}", style: const TextStyle(color: Colors.black87)),
                          Text("Estado: ${b.status}", style: const TextStyle(color: Colors.black87)),
                          Text("Páginas: ${b.pagesRead}/${b.pagesTotal}", style: const TextStyle(color: Colors.black87)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}


