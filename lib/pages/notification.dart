import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        "title": "Order Confirmed",
        "subtitle": "Your iPhone 16 Pro order has been confirmed.",
        "icon": Icons.check_circle,
        "color": Colors.green,
      },
      {
        "title": "Flash Sale",
        "subtitle": "Up to 30% off on Apple Accessories.",
        "icon": Icons.local_offer,
        "color": Colors.orange,
      },
      {
        "title": "Order Shipped",
        "subtitle": "Your package is on the way.",
        "icon": Icons.local_shipping,
        "color": Colors.blue,
      },
      {
        "title": "Payment Successful",
        "subtitle": "₹1,39,999 payment received successfully.",
        "icon": Icons.payment,
        "color": Colors.purple,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = notifications[index];

          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: (item["color"] as Color).withValues(
                  alpha: 0.15,
                ),
                child: Icon(
                  item["icon"] as IconData,
                  color: item["color"] as Color,
                ),
              ),
              title: Text(
                item["title"] as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item["subtitle"] as String),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
