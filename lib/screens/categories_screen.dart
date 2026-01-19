import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food.dart';
import '../providers/app_state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    // Pastikan sampleFoods tidak kosong
    final categories = sampleFoods.isNotEmpty
        ? ['All', ...{for (var f in sampleFoods) f.category}]
        : ['All'];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kategori Makanan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange.shade400,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final count = category == 'All'
              ? sampleFoods.length
              : sampleFoods.where((f) => f.category == category).length;

          final isSelected = category == appState.selectedCategory;

          return Card(
            color: isSelected ? Colors.orange.shade100 : Colors.white,
            elevation: isSelected ? 4 : 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: Icon(
                Icons.category_rounded,
                color: isSelected ? Colors.orange : Colors.grey.shade600,
              ),
              title: Text(
                category,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.orange.shade700 : Colors.black,
                ),
              ),
              trailing: Text(
                '$count item',
                style: TextStyle(
                  color: isSelected ? Colors.orange.shade700 : Colors.grey.shade700,
                ),
              ),
              onTap: () {
                appState.setCategory(category);
                Navigator.of(context).maybePop();
              },
            ),
          );
        },
      ),
    );
  }
}
