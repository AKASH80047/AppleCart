import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final VoidCallback onQrTap;
  final VoidCallback onCartTap;
  final VoidCallback? onSearchTap;

  const SearchBarWidget({
    super.key,
    required this.onQrTap,
    required this.onCartTap,
    this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _iconButton(icon: Icons.qr_code_scanner, onTap: onQrTap),

        const SizedBox(width: 12),

        Expanded(
          child: GestureDetector(
            onTap: onSearchTap,
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text("Search", style: TextStyle(color: Colors.grey)),
                  ),
                  Icon(Icons.camera_alt_outlined),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        _iconButton(icon: Icons.shopping_cart_outlined, onTap: onCartTap),
      ],
    );
  }

  Widget _iconButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: const Color(0xff2878E5)),
      ),
    );
  }
}
