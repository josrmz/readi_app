import 'package:flutter/material.dart';
import 'package:readi_app/models/ModeloLibro.dart';
import 'package:readi_app/providers/bookprovider.dart';

class InfoLibro extends StatelessWidget {
  const InfoLibro({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = BookProvider();

    return StreamBuilder<List<Book>>(
      stream: provider.getBooksStream(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final books = snapshot.data ?? [];

        if (books.isEmpty) {
          return const Center(
            child: Text("No hay libros añadidos aún"),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: books.length,
          itemBuilder: (context, index) {
            final b = books[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 100,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(b.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text("Autor: ${b.author}"),
                        Text("Estado: ${b.status}"),
                        Text("Páginas: ${b.pagesRead}/${b.pagesTotal}"),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
