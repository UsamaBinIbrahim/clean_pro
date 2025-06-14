class Service {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  factory Service.fromFirestore(Map<String, dynamic> data, String docId) {
    return Service(
      id: docId,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: data['price'] ?? 0,
    );
  }
}
