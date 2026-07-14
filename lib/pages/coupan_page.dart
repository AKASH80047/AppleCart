import 'package:flutter/material.dart';

class CouponPage extends StatefulWidget {
  const CouponPage({super.key});

  @override
  State<CouponPage> createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  final TextEditingController couponController = TextEditingController();

  final List<Map<String, String>> coupons = [
    {"code": "WELCOME10", "discount": "10% OFF"},
    {"code": "APPLE500", "discount": "₹500 OFF"},
    {"code": "FREESHIP", "discount": "Free Delivery"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),
      appBar: AppBar(title: const Text("Coupons"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: couponController,
              decoration: InputDecoration(
                hintText: "Enter Coupon Code",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                suffixIcon: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Coupon ${couponController.text} Applied",
                        ),
                      ),
                    );
                  },
                  child: const Text("Apply"),
                ),
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: ListView.builder(
                itemCount: coupons.length,
                itemBuilder: (_, index) {
                  final item = coupons[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: const Icon(
                        Icons.local_offer,
                        color: Colors.orange,
                      ),
                      title: Text(item["code"]!),
                      subtitle: Text(item["discount"]!),
                      trailing: ElevatedButton(
                        onPressed: () {
                          couponController.text = item["code"]!;
                        },
                        child: const Text("Use"),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
