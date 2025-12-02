import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  final String assetPath;
  const SocialIcon({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Image.asset(assetPath, width: 24, height: 24),
    );
  
  }
}