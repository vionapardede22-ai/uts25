import 'package:flutter/material.dart';
import '../models/product.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;
  final bool selected;

  const CategoryTile({
    super.key,
    required this.category,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 64,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE8F5E9) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            SizedBox(
              width: 44,
              height: 44,
              child: Image.asset(
                category.image,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Center(
                  child: Text(category.emoji,
                      style: const TextStyle(fontSize: 28)),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              category.label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                height: 1.2,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}