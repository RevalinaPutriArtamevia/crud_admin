import 'package:flutter/material.dart';
import '../services/book_service.dart';
import '../models/book_model.dart';
import 'book_detail_page.dart';

class BookPage extends StatelessWidget {
  final service = BookService();

  BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Koleksi Buku")),

      body: StreamBuilder<List<Book>>(
        stream: service.getBooks(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Belum ada buku di database"),
            );
          }

          final books = snapshot.data!;

          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final b = books[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(b.judul),
                  subtitle: Text("${b.penulis} • ${b.tahun}"),
                  trailing: Text("Stok: ${b.stok}"),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookDetailPage(book: b),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
