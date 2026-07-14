import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String? oldPrice;
  final String imageUrl;
  final int quantity;

  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;

  const CartItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    this.oldPrice,
    required this.imageUrl,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    required this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.contain,
              width: 50,
              height: 50,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: onEdit,
                      child: const Icon(
                        Icons.edit_outlined,
                        size: 18,
                        color: Color(0xFF2878E5),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        color: Color(0xFF2878E5),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    if (oldPrice != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        oldPrice!,
                        style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    _quantityButton(icon: Icons.remove, onTap: onDecrease),

                    SizedBox(
                      width: 35,
                      child: Center(
                        child: Text(
                          "$quantity",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    _quantityButton(
                      icon: Icons.add,
                      onTap: onIncrease,
                      primary: true,
                    ),

                    const Spacer(),

                    InkWell(
                      onTap: onDelete,
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFEEEE),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onTap,
    bool primary = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: primary ? const Color(0xFF2878E5) : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: primary ? const Color(0xFF2878E5) : Colors.grey.shade300,
          ),
        ),
        child: Icon(
          icon,
          size: 16,
          color: primary ? Colors.white : Colors.grey.shade700,
        ),
      ),
    );
  }
}
