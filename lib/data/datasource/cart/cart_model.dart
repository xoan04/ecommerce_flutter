class CartItem {
  String id;
  String name;
  String imageUrl;
  String color;
  double price;
  int quantity;
  int maxQuantity; // Añadir el campo maxQuantity

  CartItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.color,
    required this.price,
    required this.quantity,
    required this.maxQuantity, // Inicializar maxQuantity
  });

  factory CartItem.fromMap(Map<String, dynamic> data) {
    return CartItem(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      color: data['color'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
      quantity: data['quantity'] ?? 1,
      maxQuantity: data['maxQuantity'] ?? 1, // Inicializar maxQuantity desde el mapa
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'color': color,
      'price': price,
      'quantity': quantity,
      'maxQuantity': maxQuantity, // Añadir maxQuantity al mapa
    };
  }
}
