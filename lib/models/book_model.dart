class Book {
  String id;
  String judul;
  String penulis;
  int tahun;
  int stok;
  String deskripsi;

  Book({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.tahun,
    required this.stok,
    this.deskripsi = "",
  });

  factory Book.fromMap(String id, Map<String, dynamic> data) {
    return Book(
      id: id,
      judul: data['judul'] ?? "",
      penulis: data['penulis'] ?? "",
      tahun: data['tahun'] ?? 0,
      stok: data['stok'] ?? 0,
      deskripsi: data['deskripsi'] ?? "",
    );
  }

  Map<String, dynamic> toMap() => {
        "judul": judul,
        "penulis": penulis,
        "tahun": tahun,
        "stok": stok,
        "deskripsi": deskripsi,
      };
}
