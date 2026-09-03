import 'package:flutter/material.dart';

import '../models/product.dart';
import '../providers/cart_manager.dart';
import '../providers/wishlist_manager.dart';
import 'cart_page.dart';
import 'checkout_page.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedImage = 0;
  int selectedColor = 0;
  int selectedStorage = 0;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    quantity = 1;
    selectedColor = 0;
    selectedStorage = 0;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: AppBar(
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          ValueListenableBuilder<Set<String>>(
            valueListenable: WishlistManager().favoritesNotifier,
            builder: (context, favorites, _) {
              final isFav = favorites.contains(product.id);
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.black87,
                ),
                onPressed: () {
                  WishlistManager().toggleFavorite(product.id);
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 960;

            if (isDesktop) {
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1240),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column: Gallery
                        Expanded(
                          flex: 5,
                          child: _buildGallerySection(product, isDesktop: true),
                        ),
                        const SizedBox(width: 36),
                        // Right Column: Info & Action Buttons
                        Expanded(
                          flex: 6,
                          child: _buildInfoSection(product),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildGallerySection(product, isDesktop: false),
                  _buildInfoSection(product),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGallerySection(Product product, {required bool isDesktop}) {
    return Column(
      children: [
        Container(
          height: isDesktop ? 440 : 340,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Hero(
              tag: product.id,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  product.gallery[selectedImage],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: product.gallery.length,
            itemBuilder: (context, index) {
              final isSelected = selectedImage == index;

              return GestureDetector(
                onTap: () => setState(() => selectedImage = index),
                child: Container(
                  width: 76,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF2878E5) : const Color(0xFFE2E8F0),
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      product.gallery[index],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(Product product) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.brand.toUpperCase(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2878E5),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      product.rating.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "(${product.reviews} Customer Reviews)",
                style: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Text(
                "\$${product.price.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 28,
                  color: Color(0xFF2878E5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "\$${product.oldPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          const Text(
            "Description",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            product.description,
            style: const TextStyle(color: Color(0xFF64748B), height: 1.6),
          ),
          const SizedBox(height: 24),
          if (product.colors.isNotEmpty) ...[
            const Text(
              "Color",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: List.generate(product.colors.length, (index) {
                final selected = selectedColor == index;
                return ChoiceChip(
                  label: Text(product.colors[index]),
                  selected: selected,
                  selectedColor: const Color(0xFF2878E5),
                  backgroundColor: const Color(0xFFF1F5F9),
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : const Color(0xFF334155),
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  onSelected: (_) => setState(() => selectedColor = index),
                );
              }),
            ),
            const SizedBox(height: 20),
          ],
          if (product.storage.isNotEmpty) ...[
            const Text(
              "Storage",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: List.generate(product.storage.length, (index) {
                final selected = selectedStorage == index;
                return ChoiceChip(
                  label: Text(product.storage[index]),
                  selected: selected,
                  selectedColor: const Color(0xFF2878E5),
                  backgroundColor: const Color(0xFFF1F5F9),
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : const Color(0xFF334155),
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  onSelected: (_) => setState(() => selectedStorage = index),
                );
              }),
            ),
            const SizedBox(height: 20),
          ],
          // Quantity row
          Row(
            children: [
              const Text(
                "Quantity",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, size: 18),
                      onPressed: () {
                        if (quantity > 1) setState(() => quantity--);
                      },
                    ),
                    Text(
                      quantity.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, size: 18),
                      onPressed: () => setState(() => quantity++),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    CartManager().add(
                      product,
                      color: product.colors.isNotEmpty ? product.colors[selectedColor] : "Default",
                      storage: product.storage.isNotEmpty ? product.storage[selectedStorage] : "Default",
                      qty: quantity,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${product.name} added to cart!"),
                        backgroundColor: const Color(0xFF2878E5),
                        behavior: SnackBarBehavior.floating,
                        action: SnackBarAction(
                          label: "View Cart",
                          textColor: Colors.white,
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const CartPage()),
                          ),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: const Text("Add to Cart"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2878E5),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Color(0xFF2878E5)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    CartManager().add(
                      product,
                      color: product.colors.isNotEmpty ? product.colors[selectedColor] : "Default",
                      storage: product.storage.isNotEmpty ? product.storage[selectedStorage] : "Default",
                      qty: quantity,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CheckoutPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2878E5),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 36),
          const Text(
            "Specifications",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 12),
          _specTile("Display", "Super Retina XDR OLED"),
          _specTile("Chip", "Apple Bionic / Silicon"),
          _specTile("Operating System", "iOS / macOS"),
          _specTile("Warranty", "1 Year Apple Official Warranty"),
        ],
      ),
    );
  }

  Widget _specTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
