import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:readi_app/models/ModeloLibro.dart';

class BookProvider {
  final db = FirebaseFirestore.instance;

  Future<List<Book>> getAllBooks() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final query = await db.collection('users').doc(uid).collection('books').get();

    final books = List<Book>.from(query.docs.map((doc) {
        return Book.fromMap(doc.data());
      }),
    );

    return books;
  }

  Stream<List<Book>> getBooksStream() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final stream = db.collection('users').doc(uid).collection('books').snapshots();

    return stream.map((snapshot) {
      return snapshot.docs.map((doc) {
        return Book.fromMap(doc.data());
      }).toList();
    });
  }

  Future<void> saveBook(Book book) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await db.collection('users').doc(uid).collection('books').add(book.toMap());
  }

  Future<void> updateBook({
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await db.collection('users').doc(uid).collection('books').doc(docId).update(data);
  }

  Future<void> deleteBook(String docId) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await db.collection('users').doc(uid).collection('books').doc(docId).delete();
  }
}
