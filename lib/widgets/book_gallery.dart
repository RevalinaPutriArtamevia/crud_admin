import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../styles/app_theme.dart';

class BookGallery extends StatelessWidget {
  final List<Book> books;
  final Function(Book) onSelectBook;
  final Function(Book) onDeleteBook;

  const BookGallery({
    super.key,
    required this.books,
    required this.onSelectBook,
    required this.onDeleteBook,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.75,
      padding: const EdgeInsets.all(12),
      children: books.map((book) {
        return GestureDetector(
          onTap: () => onSelectBook(book),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  decoration: const BoxDecoration(
                    color: AppTheme.secondary,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.menu_book, size: 50),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(book.judul,
                          maxLines: 2,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold)),
                      Text(book.penulis),
                      Text("Stok: ${book.stok}"),

                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(Icons.delete,
                              color: Colors.red),
                          onPressed: () => onDeleteBook(book),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
