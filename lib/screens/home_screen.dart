import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food.dart';
import '../widgets/food_card.dart';
import 'detail_screen.dart';
import '../providers/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final selected = appState.selectedCategory;
    final query = appState.searchQuery.toLowerCase();

    // Filter logika makanan
    final foods = sampleFoods.where((f) {
      final matchCategory = selected == 'All' || f.category == selected;
      final matchQuery = f.name.toLowerCase().contains(query);
      return matchCategory && matchQuery;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Lokal Food', 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildSearchBar(appState),
          ),
          const SizedBox(height: 20),
          
          // Category List
          _buildCategoryList(appState, selected),
          
          // Grid View Makanan
          Expanded(
            child: foods.isEmpty
                ? const Center(child: Text('Makanan tidak ditemukan'))
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: foods.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // PERBAIKAN: Rasio diubah agar kotak lebih tinggi (0.75) 
                      // untuk mencegah teks harga/ikon terpotong
                      childAspectRatio: 0.75, 
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (ctx, i) => GestureDetector(
                      onTap: () => Navigator.push(
                        ctx, 
                        MaterialPageRoute(builder: (_) => DetailScreen(food: foods[i]))
                      ),
                      // Pastikan di dalam widget FoodCard menggunakan Expanded pada gambarnya
                      child: FoodCard(food: foods[i]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(AppState appState) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) => appState.setSearchQuery(value),
        decoration: const InputDecoration(
          hintText: 'Cari makanan...',
          prefixIcon: Icon(Icons.search, color: Colors.orange),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildCategoryList(AppState appState, String selected) {
    final categories = ['All', ...{for (var f in sampleFoods) f.category}];
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final c = categories[index];
          final active = c == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ChoiceChip(
              label: Text(c),
              selected: active,
              onSelected: (_) => appState.setCategory(c),
              backgroundColor: Colors.white,
              selectedColor: Colors.orange,
              // Modernize styling
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              side: BorderSide(color: active ? Colors.orange : Colors.grey[300]!),
              labelStyle: TextStyle(
                color: active ? Colors.white : Colors.black87,
                fontWeight: active ? FontWeight.bold : FontWeight.normal
              ),
              showCheckmark: false, // Menghilangkan ikon ceklis agar lebih rapi
            ),
          );
        },
      ),
    );
  }
}