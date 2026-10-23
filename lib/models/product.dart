class Category {
  final String key;
  final String label;
  final String emoji; // placeholder jika gambar asset belum ada
  final String image;

  const Category({
    required this.key,
    required this.label,
    required this.emoji,
    required this.image,
  });
}

class Product {
  final String id;
  final String name;
  final int price;
  final int stock; // dipakai untuk label "Sisa N"
  final String emoji;
  final String image;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.emoji,
    required this.image,
  });
}
