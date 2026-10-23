import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/cart_model.dart';
import '../models/product.dart';
import '../utils/format.dart';
import 'asset_or_emoji.dart';

/// Satu produk di grid Protein: gambar, tombol +/-, harga, nama, sisa stok.
/// Klik produk -> halaman detail (Pesan).
class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductTile({super.key, required this.product, required this.onTap});

  Widget _roundButton(IconData icon, VoidCallback onTap, {double size = 22}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(color: kGreen, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: size - 6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: CartModel.instance,
      builder: (context, _) {
        final cart = CartModel.instance;
        final qty = cart.qtyOf(product);
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: AssetOrEmoji(
                          asset: product.image,
                          emoji: product.emoji,
                          emojiSize: 40,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: _roundButton(Icons.add, () {
                        if (!cart.add(product)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Stok sudah habis'),
                                duration: Duration(seconds: 1)),
                          );
                        }
                      }),
                    ),
                    if (qty > 0)
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _roundButton(
                                Icons.remove, () => cart.remove(product),
                                size: 20),
                            const SizedBox(width: 2),
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.deepPurple,
                              child: Text('$qty',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 9)),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(rupiah(product.price),
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold)),
              Text(
                product.name,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 9),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Text('Sisa ${product.stock - qty}',
                    style: const TextStyle(fontSize: 9, color: kPriceRed)),
              ),
            ],
          ),
        );
      },
    );
  }
}
