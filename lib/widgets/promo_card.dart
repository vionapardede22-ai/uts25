import 'package:flutter/material.dart';

/// [Bonus] Kartu promo "Kaldu Jamur" (Diskon 100%).
/// Gambar diskon.png sudah memuat foto produk, badge diskon, dan label harga,
/// jadi cukup ditampilkan utuh dengan sudut membulat seperti di soal.
class PromoCard extends StatelessWidget {
  final String image;

  const PromoCard({
    super.key,
    this.image = 'assets/images/diskon.png',
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 439 / 487,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: const Color(0xFFF3E5F5),
            alignment: Alignment.center,
            child: const Icon(Icons.shopping_basket,
                size: 60, color: Colors.black26),
          ),
        ),
      ),
    );
  }
}
