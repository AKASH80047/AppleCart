import 'package:flutter/material.dart';

import '../models/products.dart';
import '../widgets/banner_slider.dart';
import '../widgets/category_card.dart';
import '../widgets/product_card.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBarWidget(
                onQrTap: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("QR Scanner")));
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
                // onSearchTap: () {
                //     // TODO: Search Page
                // },
              ),

              // ==========================
              // APP BAR
              // ==========================

              // Row(
              //   children: [

              //     _iconButton(
              //       Icons.qr_code_scanner,
              //       () {
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           const SnackBar(
              //             content: Text("QR Scanner"),
              //           ),
              //         );
              //       },
              //     ),

              //     const SizedBox(width: 12),

              //     Expanded(
              //       child: Container(
              //         height: 50,

              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(16),
              //         ),

              //         child: const TextField(
              //           decoration: InputDecoration(
              //             hintText: "Search Products",
              //             prefixIcon: Icon(Icons.search),
              //             suffixIcon: Icon(Icons.camera_alt_outlined),
              //             border: InputBorder.none,
              //           ),
              //         ),
              //       ),
              //     ),

              //     const SizedBox(width: 12),

              //     _iconButton(
              //       Icons.shopping_cart_outlined,
              //       () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (_) => const CartPage(),
              //           ),
              //         );
              //       },
              //     ),
              //   ],
              // ),
              const SizedBox(height: 22),

              // ==========================
              // BANNER
              // ==========================
              const BannerSlider(),

              const SizedBox(height: 30),

              // ==========================
              // CATEGORIES
              // ==========================
              const Text(
                "Categories",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 18),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1,
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

              const SizedBox(height: 30),

              Row(
                children: const [
                  Text(
                    "Flash Deals for You",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    "See All",
                    style: TextStyle(
                      color: Color(0xff2878E5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: .63,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: products[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductDetailsPage(product: products[index]),
                        ),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
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
  }
}
