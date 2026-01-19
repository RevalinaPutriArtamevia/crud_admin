
class OrderItem {
  final String id;
  final double amount;
  final List<dynamic> products; 
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}