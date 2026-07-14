import 'package:flutter/material.dart';
import '../models/product.dart';
import '../providers/wishlist_manager.dart';
import '../providers/cart_manager.dart';
import '../pages/cart_page.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.10),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Favourite Button
              Align(
                alignment: Alignment.topRight,
                child: ValueListenableBuilder<Set<String>>(
                  valueListenable: WishlistManager().favoritesNotifier,
                  builder: (context, favorites, _) {
                    final isFav = favorites.contains(product.id);
                    return GestureDetector(
                      onTap: () {
                        WishlistManager().toggleFavorite(product.id);
                      },
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey.shade100,
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),

              /// Product Image
              Expanded(
                child: Hero(
                  tag: product.id,
                  child: Image.asset(
                    product.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                product.brand,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 6),

              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    product.rating.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "(${product.reviews})",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Text(
                    "\$${product.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Color(0xff2878E5),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const Spacer(),

                  GestureDetector(
                    onTap: () {
                      CartManager().add(
                        product,
                        color: product.colors.isNotEmpty
                            ? product.colors.first
                            : "Default",
                        storage: product.storage.isNotEmpty
                            ? product.storage.first
                            : "Default",
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${product.name} added to cart!"),
                          duration: const Duration(seconds: 2),
                          action: SnackBarAction(
                            label: "View Cart",
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CartPage(),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                        color: Color(0xff2878E5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}