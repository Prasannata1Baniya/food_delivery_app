class FoodItemModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String imageUrl;

  FoodItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
  });

  factory FoodItemModel.fromFirestore(Map<String, dynamic> data, String documentId) {
    return FoodItemModel(
      id: documentId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      category: data['category'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}