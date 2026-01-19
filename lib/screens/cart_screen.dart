import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../providers/orders.dart'; 
import '../models/food.dart';
import 'payment_method_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    // Mengambil provider Orders tanpa me-listen agar tidak rebuild tidak perlu
    final ordersProvider = Provider.of<Orders>(context, listen: false); 
    final entries = appState.cart.entries.toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Keranjang Belanja',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: entries.isEmpty
          ? _buildEmptyCart(context)
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: entries.length,
                    itemBuilder: (ctx, i) {
                      final id = entries[i].key;
                      final qty = entries[i].value;
                      
                      final food = sampleFoods.firstWhere(
                        (f) => f.id == id,
                        orElse: () => Food(
                          id: '',
                          name: 'Menu Tidak Dikenal',
                          price: 0,
                          imageUrl: '',
                          category: '',
                          description: '',
                        ),
                      );

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: SizedBox(
                                width: 70,
                                height: 70,
                                child: food.imageUrl.startsWith('assets/')
                                    ? Image.asset(
                                        food.imageUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder: (c, e, s) => _buildErrorIcon(),
                                      )
                                    : Image.network(
                                        food.imageUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder: (c, e, s) => _buildErrorIcon(),
                                      ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    food.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Rp ${food.price.toStringAsFixed(0)}',
                                    style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),

                            Row(
                              children: [
                                IconButton(
                                  onPressed: () => appState.removeFromCart(id),
                                  icon: const Icon(Icons.remove_circle_outline, color: Colors.orange),
                                ),
                                Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold)),
                                IconButton(
                                  onPressed: () => appState.addToCart(id),
                                  icon: const Icon(Icons.add_circle, color: Colors.orange),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                _buildSummary(context, appState, ordersProvider),
              ],
            ),
    );
  }

  Widget _buildErrorIcon() {
    return Container(
      color: Colors.grey[200],
      child: const Icon(Icons.fastfood, color: Colors.grey),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text('Keranjangmu masih kosong', style: TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildSummary(BuildContext context, AppState appState, Orders ordersProvider) {
    final total = appState.cartTotal(sampleFoods);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Pembayaran', style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text(
                'Rp ${total.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: appState.cart.isEmpty ? null : () {
                // 1. Ekstrak data produk dari AppState menjadi List of Maps
                final List<Map<String, dynamic>> cartProducts = [];
                
                appState.cart.forEach((foodId, quantity) {
                  final food = sampleFoods.firstWhere((f) => f.id == foodId);
                  cartProducts.add({
                    'title': food.name,
                    'quantity': quantity,
                    'price': food.price,
                  });
                });

                // 2. Simpan data ke OrdersProvider
                ordersProvider.addOrder(cartProducts, total);

                // 3. Notifikasi sukses
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Berhasil Check Out! Data masuk ke Riwayat."),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );

                // 4. Bersihkan keranjang
                appState.clearCart(); 

                // 5. Navigasi ke Payment Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentMethodScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 0,
              ),
              child: const Text(
                'LANJUT KE PEMBAYARAN',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}