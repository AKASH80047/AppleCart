import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int selectedPayment = 0;

  final List<Map<String, dynamic>> methods = [
    {
      "title": "Credit / Debit Card",
      "subtitle": "Visa, MasterCard, RuPay",
      "icon": Icons.credit_card,
    },
    {
      "title": "UPI",
      "subtitle": "Google Pay, PhonePe, Paytm",
      "icon": Icons.qr_code,
    },
    {
      "title": "Net Banking",
      "subtitle": "All Major Banks",
      "icon": Icons.account_balance,
    },
    {
      "title": "Cash on Delivery",
      "subtitle": "Pay after delivery",
      "icon": Icons.payments,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Payment Methods",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: methods.length,
              itemBuilder: (context, index) {
                final item = methods[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: RadioListTile<int>(
                    value: index,
                    groupValue: selectedPayment,
                    onChanged: (value) {
                      setState(() {
                        selectedPayment = value!;
                      });
                    },
                    secondary: Icon(
                      item["icon"],
                      color: const Color(0xff2878E5),
                    ),
                    title: Text(
                      item["title"],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(item["subtitle"]),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Payment Method Selected")),
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
                  "Continue",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
