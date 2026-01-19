class Food {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}



final List<Food> sampleFoods = [
  Food(
    id: 'f1',
    name: 'Nasi Goreng Spesial',
    description: 'Nasi goreng dengan ayam, telur, dan sambal istimewa.',
    price: 18000,
    imageUrl: 'assets/images/nasi_goreng.png',
    category: 'Nasi',
  ),
  Food(
    id: 'f2',
    name: 'Mie Ayam Bakso',
    description: 'Mie kenyal dengan suwiran ayam dan bakso sapi.',
    price: 15000,
    imageUrl: 'assets/images/mie_ayam_baso.png',
    category: 'Mie',
  ),
  Food(
    id: 'f3',
    name: 'Sate Ayam Madura',
    description: 'Sate ayam dengan bumbu kacang legit dan lontong.',
    price: 22000,
    imageUrl: 'assets/images/sate_ayam.png',
    category: 'Sate',
  ),
  Food(
    id: 'f4',
    name: 'Burger Keju Double',
    description: 'Burger juicy dengan dua lapis keju dan saus spesial.',
    price: 30000,
    imageUrl: 'assets/images/burger.png',
    category: 'Burger',
  ),
  Food(
    id: 'f5',
    name: 'Salad Segar',
    description: 'Campuran sayur segar, alpukat, dan dressing lemon.',
    price: 25000,
    imageUrl: 'assets/images/salad.png',
    category: 'Salad',
  ),
  Food(
    id: 'f6',
    name: 'Nasi Padang Rendang',
    description: 'Rendang empuk dengan bumbu kaya rempah, disajikan lengkap.',
    price: 35000,
    imageUrl: 'assets/images/rendang.png',
    category: 'Nasi',
  ),
];
