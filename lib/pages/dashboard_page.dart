import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    const maroon = Color(0xff800000);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Buku"),
        backgroundColor: maroon,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Selamat Datang Admin",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: const Icon(Icons.book, color: Color(0xff800000)),
                title: const Text("Kelola Buku"),
                subtitle: const Text("Tambah, edit, hapus buku"),
                onTap: () {
                  Navigator.pushNamed(context, "/crud");
                },
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text("Logout"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
