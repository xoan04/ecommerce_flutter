import 'package:flutter_application_1/config/core/assets.dart';
import 'package:flutter_application_1/data/datasource/product/product_model.dart';
import 'package:flutter_application_1/features/presentation/ui/cart/cart_controller.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var products = <ProductModel>[].obs;
  var categories = <String, int>{}.obs;
  var selectedColor = ''.obs;
  var selectedQuantity = 1.obs;

  // Mapa de imágenes de fondo por categoría
  final Map<String, String> categoryBackgrounds = {
    'Clothes': Assets.backgroundClothesCategory,
    'Bags': Assets.backgroundBagsCategory,
    'Shoes': Assets.backgroundShoesCategory,
  };

  // Mapa de colores
  final Map<String, int> colorMap = {
    'Rojo': 0xFFFF0000,
    'Negro': 0xFF000000,
    'Azul': 0xFF0000FF,
    'Verde': 0xFF00FF00,
  };

  final CartController cartController = Get.put(CartController());

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('productos').get();
      var prodList = querySnapshot.docs.map((doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
      products.assignAll(prodList);

      // Obtener las categorías y su conteo
      Map<String, int> categoryCount = {};
      for (var product in prodList) {
        categoryCount[product.category] = (categoryCount[product.category] ?? 0) + 1;
      }
      categories.assignAll(categoryCount);
    } finally {
      isLoading(false);
    }
  }
}
