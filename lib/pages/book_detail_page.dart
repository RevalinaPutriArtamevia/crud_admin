import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../styles/app_theme.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Buku")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              book.judul,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.primary,
              ),
            ),

            const SizedBox(height: 8),

            Text("Penulis: ${book.penulis}"),
            Text("Tahun: ${book.tahun}"),
            Text("Stok: ${book.stok}"),

            const Divider(),

            const Text("Deskripsi",
                style: TextStyle(fontWeight: FontWeight.bold)),

            Text(book.deskripsi),
          ],
        ),
      ),
    );
  }
}
