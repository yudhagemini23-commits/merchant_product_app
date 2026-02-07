import 'package:flutter/material.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    // Visual indicator to provide UX feedback when local data hasn't been synced to the server
    return Container(
      color: Colors.orange.shade100,
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      child: const Text(
        "Offline Mode: Some data has not been synchronized.",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.brown, fontWeight: FontWeight.w500),
      ),
    );
  }
}