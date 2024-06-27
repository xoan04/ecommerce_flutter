class ProductModel {
  String id;
  String imageUrl;
  String name;
  String brand;
  double price;
  String category;
  String description;
  List<String> colors;
  double ratings;
  int stock;

  ProductModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.brand,
    required this.price,
    required this.category,
    required this.description,
    required this.colors,
    required this.ratings,
    required this.stock,
  });

  factory ProductModel.fromMap(Map<String, dynamic> data) {
    return ProductModel(
      id: data['id'] ?? '',
      imageUrl: data['imagen'] ?? '',
      name: data['nombre'] ?? '',
      brand: data['marca'] ?? '',
      price: data['precio']?.toDouble() ?? 0.0,
      category: data['categoria'] ?? '',
      description: data['descripcion'] ?? '',
      colors: List<String>.from(data['colores'] ?? []),
      ratings: data['cantidad_de_estrellas']?.toDouble() ?? 0.0,
      stock: data['stock']?.toInt() ?? 0, // Inicializar el campo de stock
    );
  }
}
