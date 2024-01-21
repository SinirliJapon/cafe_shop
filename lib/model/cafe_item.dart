class CafeItem {
  final int id;
  final String name;
  final double price;
  final String image;

  CafeItem({required this.id, required this.name, required this.image, required this.price});

  factory CafeItem.fromJson(Map<String, dynamic> json) {
    return CafeItem(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }
}
