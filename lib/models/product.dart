class Product {
  final String id;
  final String name;
  final String brand;
  final String image;
  final double price;
  final double oldPrice;
  final double rating;
  final int reviews;
  final bool isFavorite;
  final List<String> gallery;
  final List<String> colors;
  final List<String> storage;
  final String description;
  final String category;

  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.image,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.reviews,
    required this.isFavorite,
    required this.gallery,
    required this.colors,
    required this.storage,
    required this.description,
    required this.category,
  });

  Product copyWith({
    bool? isFavorite,
    String? category,
  }) {
    return Product(
      id: id,
      name: name,
      brand: brand,
      image: image,
      price: price,
      oldPrice: oldPrice,
      rating: rating,
      reviews: reviews,
      isFavorite: isFavorite ?? this.isFavorite,
      gallery: gallery,
      colors: colors,
      storage: storage,
      description: description,
      category: category ?? this.category,
    );
  }
}