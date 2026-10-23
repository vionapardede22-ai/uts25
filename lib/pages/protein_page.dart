import 'package:flutter/material.dart';
import '../constants.dart';
import '../data/product_data.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/cart_bar.dart';
import '../widgets/category_tile.dart';
import '../widgets/product_tile.dart';
import 'detail_page.dart';

/// Halaman list protein (muncul saat ikon Protein diklik).
/// [Bonus] filter chip, tombol +/- , label Sisa, bar Lihat Keranjang.
class ProteinPage extends StatefulWidget {
  const ProteinPage({super.key});

  @override
  State<ProteinPage> createState() => _ProteinPageState();
}

class _ProteinPageState extends State<ProteinPage> {
  final List<String> _chips = ['Semua', 'Aneka Protein Segar', 'Baru'];
  String _selectedChip = 'Semua';

  @override
  Widget build(BuildContext context) {
    final cats = proteinPageCategories;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Back + kolom search
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 12, 4),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 36,
                      child: TextField(
                        style: const TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          hintText: 'Cari lebih banyak di Terjadwal...',
                          hintStyle: const TextStyle(fontSize: 11),
                          prefixIcon: const Icon(Icons.search, size: 18),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Ikon kategori (Protein terpilih)
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: cats.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) => CategoryTile(
                  category: cats[i],
                  selected: cats[i].key == 'protein',
                  onTap: () {
                    if (cats[i].key != 'protein') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Kategori ini belum tersedia'),
                            duration: Duration(seconds: 1)),
                      );
                    }
                  },
                ),
              ),
            ),
            // Filter chips
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Row(
                      children: [
                        Icon(Icons.tune, size: 14),
                        SizedBox(width: 4),
                        Text('Filter', style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                  ..._chips.map((c) {
                    final selected = c == _selectedChip;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedChip = c),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: selected ? kGreen : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            c,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: selected ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Daftar produk (3 kolom)
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Aneka Protein Segar',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: GridView.builder(
                        itemCount: proteinProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.55,
                        ),
                        itemBuilder: (context, i) {
                          final p = proteinProducts[i];
                          return ProductTile(
                            product: p,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DetailPage(product: p)),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CartBar(),
          AppBottomNav(current: NavTab.home),
        ],
      ),
    );
  }
}
