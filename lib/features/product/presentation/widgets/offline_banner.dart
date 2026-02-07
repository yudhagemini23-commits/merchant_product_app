import 'package:flutter/material.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange.shade100,
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      child: const Text(
        "Mode Offline: Beberapa data belum disinkronkan.",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.brown),
      ),
    );
  }
}