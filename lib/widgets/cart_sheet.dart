import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/cart_model.dart';
import '../utils/format.dart';

/// Lembar bawah berisi ringkasan keranjang.
void showCartSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    builder: (_) => ListenableBuilder(
      listenable: CartModel.instance,
      builder: (context, _) {
        final cart = CartModel.instance;
        final lines = cart.lines;
        if (lines.isEmpty) {
          return const SizedBox(
            height: 140,
            child: Center(child: Text('Keranjang masih kosong')),
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: lines.map((e) {
                  final p = e.key;
                  final qty = e.value;
                  return ListTile(
                    dense: true,
                    title: Text(p.name, style: const TextStyle(fontSize: 12)),
                    subtitle: Text(rupiah(p.price * qty),
                        style: const TextStyle(fontSize: 11)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          color: kGreen,
                          onPressed: () => cart.remove(p),
                        ),
                        Text('$qty'),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          color: kGreen,
                          onPressed: () => cart.add(p),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              child: Row(
                children: [
                  const Text('Total',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text(rupiah(cart.totalPrice),
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );
}
