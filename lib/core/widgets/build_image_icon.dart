import 'package:flutter/material.dart';

class ImageIcons {
  Widget buildImageIcon(String asset, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 48,
        height: 48,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Image.asset(
          asset,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.broken_image_rounded,
            color: Colors.grey,
            size: 24,
          ),
        ),
      ),
    );
  }

  Widget buildFabImage(String asset, String keyValue) {
    return Padding(
      key: ValueKey(keyValue),
      padding: const EdgeInsets.all(10),
      child: Image.asset(
        asset,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => const Icon(
          Icons.broken_image_rounded,
          color: Colors.grey,
          size: 24,
        ),
      ),
    );
  }
}