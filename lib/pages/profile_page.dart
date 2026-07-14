import 'package:flutter/material.dart';
import 'orders_page.dart';
import 'address_page.dart';
import 'payment_page.dart';
import 'wishlist_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/profile.png"),
            ),

            const SizedBox(height: 15),

            const Text(
              "Akash Pandey",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            const Text(
              "Flutter Developer",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            _tile(context, Icons.shopping_bag_outlined, "My Orders", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrdersPage()),
              );
            }),

            _tile(context, Icons.favorite_border, "Wishlist", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WishlistPage()),
              );
            }),

            _tile(context, Icons.location_on_outlined, "Delivery Address", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddressPage()),
              );
            }),
            _tile(context, Icons.payment_outlined, "Payment Methods", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PaymentPage()),
              );
            }),

            _tile(context, Icons.settings_outlined, "Settings", () {}),

            _tile(context, Icons.help_outline, "Help & Support", () {}),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}
