import 'package:flutter/material.dart';
import '../models/product.dart';
import '../providers/wishlist_manager.dart';
import '../providers/cart_manager.dart';
import 'cart_page.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late int selectedImage;

  late int quantity;

  late int selectedColor;

  late int selectedStorage;

  @override
  void initState() {
    super.initState();

    selectedImage = 0;
    quantity = 1;
    selectedColor = 0;
    selectedStorage = 0;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ===========================
              // IMAGE SECTION
              // ===========================
              Container(
                height: 380,
                width: double.infinity,
                color: Colors.white,

                child: Stack(
                  children: [
                    Center(
                      child: Hero(
                        tag: product.id,

                        child: Image.asset(
                          product.gallery[selectedImage],
                          fit: BoxFit.contain,
                          height: 260,
                        ),
                      ),
                    ),

                    Positioned(
                      left: 16,
                      top: 16,

                      child: CircleAvatar(
                        backgroundColor: Colors.white,

                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),

                    Positioned(
                      right: 16,
                      top: 16,

                      child: ValueListenableBuilder<Set<String>>(
                        valueListenable: WishlistManager().favoritesNotifier,
                        builder: (context, favorites, _) {
                          final isFav = favorites.contains(product.id);
                          return CircleAvatar(
                            backgroundColor: Colors.white,

                            child: IconButton(
                              icon: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                WishlistManager().toggleFavorite(product.id);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ===========================
              // IMAGE THUMBNAILS
              // ===========================
              SizedBox(
                height: 90,

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: product.gallery.length,

                  itemBuilder: (context, index) {
                    final isSelected = selectedImage == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImage = index;
                        });
                      },

                      child: Container(
                        width: 70,
                        margin: const EdgeInsets.symmetric(horizontal: 8),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(16),

                          border: Border.all(
                            color: isSelected
                                ? Colors.blue
                                : Colors.transparent,
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

              const SizedBox(height: 20),

              // 👇 Part 2 yahin se continue hoga...
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Brand
                    Text(
                      product.brand.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// Product Name
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// Rating
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),

                        const SizedBox(width: 5),

                        Text(
                          product.rating.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(width: 8),

                        Text(
                          "(${product.reviews} Reviews)",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// Price
                    Row(
                      children: [
                        Text(
                          "\$${product.price.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Text(
                          "\$${product.oldPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    /// Description
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      product.description,
                      style: const TextStyle(color: Colors.grey, height: 1.6),
                    ),

                    const SizedBox(height: 30),
                    const Text(
                      "Available Colors",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Wrap(
                      spacing: 10,
                      children: List.generate(product.colors.length, (index) {
                        final selected = selectedColor == index;

                        return ChoiceChip(
                          label: Text(product.colors[index]),

                          selected: selected,

                          onSelected: (_) {
                            setState(() {
                              selectedColor = index;
                            });
                          },
                        );
                      }),
                    ),

                    const SizedBox(height: 25),
                    const Text(
                      "Storage",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Wrap(
                      spacing: 10,
                      children: List.generate(product.storage.length, (index) {
                        return ChoiceChip(
                          label: Text(product.storage[index]),

                          selected: selectedStorage == index,

                          onSelected: (_) {
                            setState(() {
                              selectedStorage = index;
                            });
                          },
                        );
                      }),
                    ),

                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Text(
                          "Quantity",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        const Spacer(),

                        IconButton(
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                              });
                            }
                          },
                          icon: const Icon(Icons.remove_circle_outline),
                        ),

                        Text(
                          quantity.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    /// ===========================
                    /// Action Buttons
                    /// ===========================
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              CartManager().add(
                                product,
                                color: product.colors.isNotEmpty
                                    ? product.colors[selectedColor]
                                    : "Default",
                                storage: product.storage.isNotEmpty
                                    ? product.storage[selectedStorage]
                                    : "Default",
                                qty: quantity,
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
                            icon: const Icon(Icons.shopping_cart_outlined),
                            label: const Text("Add to Cart"),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Proceeding to Checkout"),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff2878E5),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text(
                              "Buy Now",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Text(
                      "A Snapshot View",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: product.gallery.length,
                        itemBuilder: (context, index) {
                          final isSelected = selectedImage == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedImage = index;
                              });
                            },
                            child: Container(
                              width: 120,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xff2878E5)
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withValues(alpha: 0.08),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                    product.gallery[index],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 25),

                    const Text(
                      "Specifications",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 15),

                    _specTile("Display", "6.9-inch Super Retina XDR"),
                    _specTile("Chip", "Apple A18 Pro"),
                    _specTile("Camera", "48MP + 48MP + 12MP"),
                    _specTile("Battery", "Up to 33 Hours"),
                    _specTile("Operating System", "iOS 26"),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _specTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
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
