import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil data dari provider
    final orderData = Provider.of<Orders>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: orderData.orders.isEmpty 
        ? const Center(child: Text('Belum ada riwayat pesanan.'))
        : ListView.builder(
            itemCount: orderData.orders.length,
            itemBuilder: (ctx, i) {
              final order = orderData.orders[i];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ExpansionTile(
                  title: Text('Total: Rp ${order.amount.toStringAsFixed(0)}'),
                  subtitle: Text(
                    DateFormat('dd/MM/yyyy HH:mm').format(order.dateTime),
                  ),
                  children: [
                    // Loop produk di dalam order tersebut
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Column(
                        children: order.products.map((prod) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // PENTING: Gunakan prod['key'] karena datanya berupa Map
                              Text(
                                "${prod['title']}", 
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${prod['quantity']}x @ Rp ${prod['price']}",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
    );
  }
}