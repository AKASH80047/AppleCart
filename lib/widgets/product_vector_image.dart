import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ProductVectorImage extends StatelessWidget {
  final String imageType; // 'phone' or 'watch'
  final String colorName; // For matching specific titanium color
  final double height;
  final double width;

  const ProductVectorImage({
    super.key,
    required this.imageType,
    this.colorName = "Natural Titanium",
    this.height = 150,
    this.width = 120,
  });

  Color getDeviceColor() {
    switch (colorName.trim()) {
      case 'Desert Titanium':
        return AppColors.desertTitanium;

      case 'Natural Titanium':
        return AppColors.naturalTitanium;

      case 'White Titanium':
        return AppColors.whiteTitanium;

      case 'Black Titanium':
        return AppColors.blackTitanium;

      case 'Black':
        return const Color(0xFF1A1A1A);

      case 'Orange':
        return const Color(0xFFFF5A2B);

      case 'Silver':
        return const Color(0xFFE2E2E2);

      default:
        return AppColors.naturalTitanium;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color devColor = getDeviceColor();

    if (imageType == 'phone') {
      return SizedBox(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Shadow behind the phone
            Container(
              width: width * 0.72,
              height: height * 0.88,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
            ),
            // Phone Chassis (back view)
            Container(
              width: width * 0.75,
              height: height * 0.9,
              decoration: BoxDecoration(
                color: devColor,
                borderRadius: BorderRadius.circular(width * 0.14),
                border: Border.all(
                  color: devColor.withValues(alpha: 0.8),
                  width: 2.5,
                ),
              ),
              child: Stack(
                children: [
                  // Camera Bump (Top Left)
                  Positioned(
                    top: height * 0.05,
                    left: width * 0.05,
                    child: Container(
                      width: width * 0.32,
                      height: width * 0.32,
                      decoration: BoxDecoration(
                        color: devColor.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(width * 0.06),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 4,
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Lens 1
                          Positioned(
                            top: 4,
                            left: 4,
                            child: _buildCameraLens(width * 0.12),
                          ),
                          // Lens 2
                          Positioned(
                            bottom: 4,
                            left: 4,
                            child: _buildCameraLens(width * 0.12),
                          ),
                          // Lens 3
                          Positioned(
                            right: 4,
                            top: width * 0.08,
                            child: _buildCameraLens(width * 0.12),
                          ),
                          // Flash
                          Positioned(
                            right: 8,
                            top: 6,
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          // LiDAR
                          Positioned(
                            right: 8,
                            bottom: 8,
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.6),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Apple logo (center minimal drawing)
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: width * 0.12,
                      height: width * 0.12,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.apple,
                          size: width * 0.09,
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      // Smartwatch drawing
      return SizedBox(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Strap (Top)
            Positioned(
              top: 0,
              child: Container(
                width: width * 0.4,
                height: height * 0.35,
                decoration: BoxDecoration(
                  color: devColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(width * 0.08),
                    topRight: Radius.circular(width * 0.08),
                  ),
                ),
              ),
            ),
            // Strap (Bottom)
            Positioned(
              bottom: 0,
              child: Container(
                width: width * 0.4,
                height: height * 0.35,
                decoration: BoxDecoration(
                  color: devColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(width * 0.08),
                    bottomRight: Radius.circular(width * 0.08),
                  ),
                ),
              ),
            ),
            // Watch Body shadow
            Container(
              width: width * 0.62,
              height: height * 0.62,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
            ),
            // Watch Body (Titanium)
            Container(
              width: width * 0.65,
              height: height * 0.65,
              decoration: BoxDecoration(
                color: const Color(0xFFC0C1C4), // Ultra Orange / Silver casing
                borderRadius: BorderRadius.circular(width * 0.16),
                border: Border.all(color: const Color(0xFFE2E2E2), width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(width * 0.12),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Circular watch face dial
                      Container(
                        width: width * 0.42,
                        height: width * 0.42,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.orange.withValues(alpha: 0.8),
                            width: 1.5,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Hour/Minute marks
                            for (var i = 0; i < 8; i++)
                              Transform.rotate(
                                angle: i * (3.14159 / 4),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: 1.5,
                                    height: 3,
                                    color: Colors.white54,
                                  ),
                                ),
                              ),
                            // Orange watch hands
                            Positioned(
                              top: width * 0.08,
                              child: Container(
                                width: 2,
                                height: width * 0.13,
                                color: Colors.orange,
                              ),
                            ),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Time text overlay
                      Positioned(
                        top: 4,
                        child: Text(
                          "09:41",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.08,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      // Activity Rings (Tiny indicator)
                      Positioned(
                        bottom: 6,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 4,
                              height: 4,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Digital Crown (Side dial)
            Positioned(
              right: width * 0.12,
              top: height * 0.38,
              child: Container(
                width: 6,
                height: 18,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF5A2B), // Orange stripe on crown
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
            // Action Button (Left side)
            Positioned(
              left: width * 0.13,
              top: height * 0.44,
              child: Container(
                width: 4,
                height: 14,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF5A2B),
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildCameraLens(double size) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color(0xFF101010),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: size * 0.8,
          height: size * 0.8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white24, width: 1),
          ),
          child: Center(
            child: Container(
              width: size * 0.35,
              height: size * 0.35,
              decoration: const BoxDecoration(
                color: Color(0xFF030303),
                shape: BoxShape.circle,
              ),
              child: Align(
                alignment: const Alignment(-0.3, -0.3),
                child: Container(
                  width: 2,
                  height: 2,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
