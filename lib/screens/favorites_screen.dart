import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../models/food.dart';
import '../widgets/food_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final favs = sampleFoods.where((f) => appState.favorites.contains(f.id)).toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(title: const Text('Favorit'), backgroundColor: Colors.transparent, elevation: 0),
      body: favs.isEmpty
          ? Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1), // Perbaikan di sini
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.favorite_border, size: 80, color: Colors.orange),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (ctx, i) => FoodCard(food: favs[i]),
            ),
    );
  }
}