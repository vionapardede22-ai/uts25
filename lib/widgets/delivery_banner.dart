import 'package:flutter/material.dart';

class DeliveryBanner extends StatelessWidget {
  const DeliveryBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 76,
      color: const Color(0xFFFF9800),
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Dikirim Besok',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('ke Pilih Lokasi',
                        style: TextStyle(fontSize: 11, color: Colors.black87)),
                    Icon(Icons.keyboard_arrow_down,
                        size: 16, color: Colors.black87),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 170,
            height: 76,
            child: Image.asset(
              'assets/images/tem.png',
              fit: BoxFit.cover,
              alignment: Alignment.centerRight,
              errorBuilder: (_, __, ___) => const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Text('🥬🥕', style: TextStyle(fontSize: 32)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}