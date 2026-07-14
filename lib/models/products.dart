import '../models/product.dart';

const List<Product> products = [
  Product(
    id: "1",
    name: "Iphone 16 Pro Max",
    brand: "Apple",
    image: "assets/images/iPhone1.jpg",
    price: 1399.99,
    oldPrice: 1499.99,
    rating: 4.9,
    reviews: 2234,
    isFavorite: false,
    gallery: [
      "assets/images/iPhone1.jpg",
      "assets/images/iPhone2.jpeg",
      "assets/images/iPhone3.jpg",
      "assets/images/iPhone4.jpeg",
    ],
    colors: [
      "Natural Titanium",
      "Black Titanium",
      "White Titanium",
      "Desert Titanium",
    ],
    storage: [
      "128 GB",
      "256 GB",
      "512 GB",
      "1 TB",
    ],
    description:
        "iPhone 16 Pro Max features the powerful A18 Pro chip, ProMotion display, titanium design, and an advanced professional camera system.",
    category: "Mobiles",
  ),

  Product(
    id: "2",
    name: "Smartwatch Ultra",
    brand: "Apple",
    image: "assets/images/SmartwatchUltra.png",
    price: 799.99,
    oldPrice: 899.99,
    rating: 4.8,
    reviews: 1420,
    isFavorite: false,
    gallery: [
      "assets/images/SmartwatchUltra.png",
    ],
    colors: [
      "Black",
      "Orange",
      "Silver",
    ],
    storage: [
      "49 mm",
    ],
    description:
        "Apple Watch Ultra 2 with GPS + Cellular, titanium case and the brightest display.",
    category: "Watch",
  ),

  Product(
    id: "3",
    name: "iPhone 15 Pro",
    brand: "Apple",
    image: "assets/images/iPhone15Pro.png",
    price: 999.99,
    oldPrice: 1099.99,
    rating: 4.8,
    reviews: 1840,
    isFavorite: false,
    gallery: [
      "assets/images/iPhone15Pro.png",
    ],
    colors: [
      "Natural Titanium",
      "Blue Titanium",
      "White Titanium",
      "Black Titanium",
    ],
    storage: [
      "128 GB",
      "256 GB",
      "512 GB",
      "1 TB",
    ],
    description:
        "iPhone 15 Pro with Aerospace-grade titanium design, A17 Pro chip, customizable Action button, and a powerful iPhone camera system.",
    category: "Mobiles",
  ),

  Product(
    id: "4",
    name: "AirPods Pro 2",
    brand: "Apple",
    image: "assets/images/AirPodsPro.png",
    price: 249.99,
    oldPrice: 299.99,
    rating: 4.9,
    reviews: 5100,
    isFavorite: false,
    gallery: [
      "assets/images/AirPodsPro.png",
    ],
    colors: [
      "White",
    ],
    storage: [
      "USB-C",
    ],
    description:
        "AirPods Pro with Active Noise Cancellation, Adaptive Audio and Personalized Spatial Audio.",
    category: "AirPods",
  ),

  Product(
    id: "5",
    name: "MacBook Air M3",
    brand: "Apple",
    image: "assets/images/MacBookAir.png",
    price: 1199.99,
    oldPrice: 1299.99,
    rating: 4.8,
    reviews: 920,
    isFavorite: false,
    gallery: [
      "assets/images/MacBookAir.png",
    ],
    colors: [
      "Midnight",
      "Space Grey",
      "Silver",
      "Starlight",
    ],
    storage: [
      "256 GB",
      "512 GB",
      "1 TB",
    ],
    description:
        "Supercharged by the next-generation M3 chip, the incredibly thin and fast MacBook Air blazes through work and play.",
    category: "Laptop",
  ),

  Product(
    id: "6",
    name: "HomePod Mini",
    brand: "Apple",
    image: "assets/images/homepod.png",
    price: 99.00,
    oldPrice: 119.00,
    rating: 4.7,
    reviews: 310,
    isFavorite: false,
    gallery: [
      "assets/images/homepod.png",
    ],
    colors: [
      "Space Grey",
      "White",
      "Blue",
      "Yellow",
      "Orange",
    ],
    storage: [
      "Standard",
    ],
    description:
        "HomePod mini delivers unexpectedly big sound for a speaker of its size. Place multiple speakers around the house to have a connected sound system.",
    category: "Speaker",
  ),
];