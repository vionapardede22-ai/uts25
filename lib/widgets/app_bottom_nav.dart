import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/cart_model.dart';
import 'cart_sheet.dart';

enum NavTab { home, search, cart, account }

/// [Wajib] Bottom navigation melayang: home, search, keranjang, akun.
/// Ikon memakai ikon bawaan Flutter (Icons).
class AppBottomNav extends StatelessWidget {
  final NavTab current;
  const AppBottomNav({super.key, this.current = NavTab.home});

  void _goHome(BuildContext context) {
    if (current == NavTab.home) return;
    // kembali ke halaman Home (route bernama '/home')
    Navigator.popUntil(context, (r) => r.settings.name == '/home');
  }

  void _info(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg), duration: const Duration(seconds: 1)));
  }

  Widget _icon(IconData icon, bool active, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon,
            size: 22, color: active ? kOrange : Colors.grey.shade700),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 4, 12, 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Row(
          children: [
            _icon(Icons.home_filled, current == NavTab.home,
                () => _goHome(context)),
            _icon(Icons.search, current == NavTab.search,
                () => _info(context, 'Fitur pencarian belum tersedia')),
            const Spacer(),
            _icon(Icons.shopping_basket_outlined, current == NavTab.cart, () {
              if (CartModel.instance.totalItems == 0) {
                _info(context, 'Keranjang masih kosong');
              } else {
                showCartSheet(context);
              }
            }),
            _icon(Icons.person_outline, current == NavTab.account,
                () => _info(context, 'Halaman akun belum tersedia')),
          ],
        ),
      ),
    );
  }
}
