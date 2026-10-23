import 'package:flutter/material.dart';
import '../constants.dart';
import '../data/product_data.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/cart_bar.dart'; // <-- baru
import '../widgets/category_tile.dart';
import '../widgets/delivery_banner.dart';
import '../widgets/promo_card.dart';
import 'protein_page.dart';

class HomePage extends StatelessWidget {
  final String storeName;
  const HomePage({super.key, required this.storeName});

  void _onCategoryTap(BuildContext context, String key) {
    if (key == 'protein') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ProteinPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kategori ini belum tersedia'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: const Text('Home'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListTile(
            leading: const Icon(Icons.store),
            title: Text(storeName),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Text(
              storeName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GridView.count(
              crossAxisCount: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 0.7,
              mainAxisSpacing: 8,
              children: categories
                  .map((c) => CategoryTile(
                        category: c,
                        onTap: () => _onCategoryTap(context, c.key),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 12),
          const DeliveryBanner(),
          const SizedBox(height: 4),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Lihat Lebih Banyak',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: kGreen,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, size: 18, color: kGreen),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: PromoCard()),
                SizedBox(width: 12),
                Expanded(child: PromoCard()),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
      // <-- diubah: CartBar di atas bottom nav
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CartBar(
            totalItems: 0, // ganti dengan data dari cart_model
            totalPrice: 0, // ganti dengan data dari cart_model
            onTap: () {
              // buka cart_sheet.dart
            },
          ),
          const AppBottomNav(current: NavTab.home),
        ],
      ),
    );
  }
}