import '../models/product.dart';

const List<Category> categories = [
  Category(key: 'terbaru', label: 'Produk\nTerbaru', emoji: '🆕', image: 'assets/images/new.png'),
  Category(key: 'belilagi', label: 'Beli Lagi', emoji: '🛒', image: 'assets/images/beli lagi.png'),
  Category(key: 'protein', label: 'Protein', emoji: '🥩', image: 'assets/images/protein.png'),
  Category(key: 'sayur', label: 'Sayur', emoji: '🥬', image: 'assets/images/sayur.png'),
  Category(key: 'buah', label: 'Buah', emoji: '🍊', image: 'assets/images/buah.png'),
  
];

Category categoryByKey(String key) =>
    categories.firstWhere((c) => c.key == key);

/// Urutan ikon kategori di halaman Protein (sesuai screenshot soal).
List<Category> get proteinPageCategories => [
      categoryByKey('terbaru'),
      categoryByKey('belilagi'),
      categoryByKey('protein'),
      categoryByKey('sayur'),
      categoryByKey('buah'),
    ];

const List<Product> proteinProducts = [
  Product(id: 'p1', name: 'Sayurbox Daging Giling Segar 250 g', price: 51900, stock: 3, emoji: '🥩', image: 'assets/images/1.png'),
  Product(id: 'p2', name: 'Daging Has Luar Segar 250 g', price: 49900, stock: 1, emoji: '🥩', image: 'assets/images/2.png'),
  Product(id: 'p3', name: 'Sayurbox Daging Sengkel Segar 250 g', price: 49900, stock: 3, emoji: '🍖', image: 'assets/images/3.png'),
  Product(id: 'p4', name: 'Daging Has Dalam Segar', price: 62900, stock: 5, emoji: '🥩', image: 'assets/images/4.png'),
  Product(id: 'p5', name: 'Sayurbox Iga Sapi Segar', price: 64900, stock: 4, emoji: '🍖', image: 'assets/images/5.png'),
  Product(id: 'p6', name: 'Teri Nasi Basah Tidak Beku', price: 26100, stock: 6, emoji: '🐟', image: 'assets/images/6.png'),
];
