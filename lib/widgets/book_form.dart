import 'package:flutter/material.dart';
import '../models/book_model.dart';

class BookForm extends StatefulWidget {
  final Function(Book) onSubmit;

  const BookForm({super.key, required this.onSubmit});

  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final j = TextEditingController();
  final p = TextEditingController();
  final t = TextEditingController();
  final s = TextEditingController();

  @override
  Widget build(BuildContext c) {
    return Column(children: [
      TextField(controller: j),
      TextField(controller: p),
      TextField(controller: t),
      TextField(controller: s),

      ElevatedButton(
        onPressed: () {
          widget.onSubmit(Book(
            id: '',
            judul: j.text,
            penulis: p.text,
            tahun: int.parse(t.text),
            stok: int.parse(s.text),
          ));
        },
        child: const Text("Simpan"),
      )
    ]);
  }
}
