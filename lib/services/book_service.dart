import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book_model.dart';

class BookService {
  final col = FirebaseFirestore.instance.collection('books');

  Stream<List<Book>> getBooks() {
    return col.snapshots().map((s) {
      return s.docs.map((e) {
        return Book.fromMap(e.id, e.data());
      }).toList();
    });
  }

  Future deleteBook(String id) => col.doc(id).delete();
}
