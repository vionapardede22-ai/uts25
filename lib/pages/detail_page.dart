import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';
import '../models/product.dart';
import '../utils/format.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/asset_or_emoji.dart';

/// Halaman "Pesan": nama, gambar, harga, tombol Order via WhatsApp.
class DetailPage extends StatelessWidget {
  final Product product;
  const DetailPage({super.key, required this.product});

  /// Membersihkan nomor: hanya angka, dan awalan 0 diganti 62.
  String _normalizedNumber() {
    var n = kWhatsAppNumber.replaceAll(RegExp(r'[^0-9]'), '');
    if (n.startsWith('0')) n = '62${n.substring(1)}';
    return n;
  }

  Future<void> _orderViaWhatsApp(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);

    final text = Uri.encodeComponent(
        'Halo, saya ingin memesan ${product.name} (${rupiah(product.price)}).');
    final uri = Uri.parse('https://wa.me/${_normalizedNumber()}?text=$text');

    var opened = false;

    // 1) Coba buka langsung di aplikasi WhatsApp
    try {
      opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      opened = false;
    }

    // 2) Jika gagal, coba cara default (misalnya lewat browser)
    if (!opened) {
      try {
        opened = await launchUrl(uri, mode: LaunchMode.platformDefault);
      } catch (_) {
        opened = false;
      }
    }

    if (!opened) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka WhatsApp')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        title: const Text('Pesan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            // Nama produk: besar, tebal, merah, terpecah 2 baris
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 210),
                child: Text(
                  product.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    height: 1.5,
                    color: kPriceRed,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Gambar penuh selebar layar, tanpa sudut membulat
            SizedBox(
              width: double.infinity,
              height: 240,
              child: AssetOrEmoji(
                asset: product.image,
                emoji: product.emoji,
                emojiSize: 72,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              rupiah(product.price),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: kPriceRed,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () => _orderViaWhatsApp(context),
              icon: const Icon(Icons.chat),
              label: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Order via WhatsApp',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Klik di Sini!', style: TextStyle(fontSize: 9)),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(current: NavTab.home),
    );
  }
}