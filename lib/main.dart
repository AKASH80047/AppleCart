import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/chat_page.dart';
import 'pages/cart_page.dart';
import 'pages/profile_page.dart';
import 'pages/wishlist_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppleMart());
}

class AppleMart extends StatelessWidget {
  const AppleMart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppleMart',
      home: const HomePage(),

      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'SF Pro Display',
        scaffoldBackgroundColor: const Color(0xFFF8F9FD),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2878E5),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
        ),
      ),

      routes: {
  "/chat": (context) => const ChatPage(),
  "/wishlist": (context) => const WishlistPage(),
  "/cart": (context) => const CartPage(),
  "/profile": (context) => const ProfilePage(),
},
    );
  }
}