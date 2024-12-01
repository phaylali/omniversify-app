import 'package:flutter/material.dart';

class ResponsiveWidth {
  static double getContentWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Mobile devices
    if (screenWidth < 600) {
      return screenWidth * 0.95; // 95% of screen width
    }
    // Tablets and PCs
    else {
      return screenWidth * 0.6; // 60% of screen width
    }
  }

  static EdgeInsets getHorizontalPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Mobile devices
    if (screenWidth < 600) {
      return const EdgeInsets.symmetric(horizontal: 8.0);
    }
    // Tablets and PCs
    else {
      return const EdgeInsets.symmetric(horizontal: 16.0);
    }
  }
}
