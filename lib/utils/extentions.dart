import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  // Define an onTap extension method that takes a VoidCallback
  Widget onTap(VoidCallback onTap) {
    // Wrap the original widget with a GestureDetector
    return GestureDetector(
      onTap: onTap,
      child: this, // 'this' refers to the original widget
    );
  }
}
