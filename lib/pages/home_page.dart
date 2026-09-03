import 'package:flutter/material.dart';

import '../models/products.dart';
import '../widgets/banner_slider.dart';
import '../widgets/category_card.dart';
import '../widgets/product_card.dart';
import '../providers/cart_manager.dart';
import '../providers/wishlist_manager.dart';

import 'product_details_page.dart';
import 'chat_page.dart';
import 'wishlist_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';
import '../widgets/search_bar_widget.dart';
import 'search_page.dart';
import 'category_products_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Map<String, dynamic>> categories = [
    {"title": "Mobiles", "icon": Icons.phone_iphone},
    {"title": "Laptop", "icon": Icons.laptop_mac},
    {"title": "Watch", "icon": Icons.watch},
    {"title": "AirPods", "icon": Icons.headphones},
    {"title": "Speaker", "icon": Icons.speaker},
    {"title": "More", "icon": Icons.grid_view_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 960;
        final isTablet = constraints.maxWidth >= 640 && constraints.maxWidth < 960;

        return Scaffold(
          backgroundColor: const Color(0xffF6F7FB),
          appBar: isDesktop ? _buildDesktopNavbar(context) : null,
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1240),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 24 : 18,
                    vertical: 18,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isDesktop) ...[
                        SearchBarWidget(
                          onQrTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("QR Scanner")),
                            );
                          },
                          onCartTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const CartPage()),
                            );
                          },
                          onSearchTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const SearchPage()),
                            );
                          },
                        ),
                        const SizedBox(height: 22),
                      ],

                      // ==========================
                      // BANNER SLIDER
                      // ==========================
                      const BannerSlider(),

                      const SizedBox(height: 30),

                      // ==========================
                      // CATEGORIES
                      // ==========================
                      const Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),

                      const SizedBox(height: 18),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categories.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isDesktop ? 6 : (isTablet ? 4 : 3),
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: isDesktop ? 1.1 : 1.0,
                        ),
                        itemBuilder: (context, index) {
                          return CategoryCard(
                            title: categories[index]["title"],
                            icon: categories[index]["icon"],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CategoryProductsPage(
                                    categoryName: categories[index]["title"],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 32),

                      // ==========================
                      // FLASH DEALS HEADER
                      // ==========================
                      Row(
                        children: [
                          const Text(
                            "Flash Deals for You",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "See All",
                              style: TextStyle(
                                color: Color(0xff2878E5),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // ==========================
                      // RESPONSIVE PRODUCTS GRID
                      // ==========================
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isDesktop ? 4 : (isTablet ? 3 : 2),
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: isDesktop ? 0.72 : (isTablet ? 0.68 : 0.63),
                        ),
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: products[index],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductDetailsPage(product: products[index]),
                                ),
                              );
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 36),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: isDesktop
              ? null
              : BottomNavigationBar(
                  currentIndex: currentIndex,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: const Color(0xff2878E5),
                  unselectedItemColor: Colors.grey,
                  onTap: (index) {
                    setState(() {
                      currentIndex = index;
                    });

                    switch (index) {
                      case 0:
                        break;
                      case 1:
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ChatPage()),
                        );
                        break;
                      case 2:
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const WishlistPage()),
                        );
                        break;
                      case 3:
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CartPage()),
                        );
                        break;
                      case 4:
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ProfilePage()),
                        );
                        break;
                    }
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      activeIcon: Icon(Icons.home),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.chat_bubble_outline),
                      activeIcon: Icon(Icons.chat),
                      label: "Chat",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border),
                      activeIcon: Icon(Icons.favorite),
                      label: "Wishlist",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart_outlined),
                      activeIcon: Icon(Icons.shopping_cart),
                      label: "Cart",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline),
                      activeIcon: Icon(Icons.person),
                      label: "Profile",
                    ),
                  ],
                ),
        );
      },
    );
  }

  PreferredSizeWidget _buildDesktopNavbar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(72),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1240),
            child: Row(
              children: [
                // Brand Logo
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.apple, color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "AppleMart",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 32),

                // Desktop Search Bar
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SearchPage()),
                      );
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.search, color: Colors.grey, size: 20),
                          SizedBox(width: 10),
                          Text(
                            "Search Apple devices, accessories...",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          Spacer(),
                          Icon(Icons.camera_alt_outlined, color: Colors.grey, size: 18),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 32),

                // Navigation Items
                _desktopNavAction(
                  icon: Icons.chat_bubble_outline,
                  label: "Chat",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ChatPage()),
                  ),
                ),
                const SizedBox(width: 18),

                ListenableBuilder(
                  listenable: WishlistManager().favoritesNotifier,
                  builder: (context, _) {
                    final count = WishlistManager().favoriteIds.length;
                    return _desktopNavAction(
                      icon: Icons.favorite_border,
                      label: "Wishlist",
                      badge: count > 0 ? count.toString() : null,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const WishlistPage()),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 18),

                ListenableBuilder(
                  listenable: CartManager(),
                  builder: (context, _) {
                    final count = CartManager().totalItems;
                    return _desktopNavAction(
                      icon: Icons.shopping_cart_outlined,
                      label: "Cart",
                      badge: count > 0 ? count.toString() : null,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartPage()),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 18),

                _desktopNavAction(
                  icon: Icons.person_outline,
                  label: "Account",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfilePage()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _desktopNavAction({
    required IconData icon,
    required String label,
    String? badge,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, color: const Color(0xFF334155), size: 22),
                if (badge != null)
                  Positioned(
                    right: -6,
                    top: -6,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Color(0xFF2878E5),
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Center(
                        child: Text(
                          badge,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xFF334155),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
