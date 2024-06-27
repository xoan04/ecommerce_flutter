import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/datasource/cart/cart_model.dart';
import 'package:flutter_application_1/features/presentation/themes/app_colors.dart';
import 'package:flutter_application_1/features/presentation/ui/cart/cart_controller.dart';
import 'package:flutter_application_1/features/presentation/ui/widgets/custom_elevated_button.dart';
import 'package:flutter_application_1/features/presentation/ui/widgets/quantity_selector.dart';
import 'package:flutter_application_1/data/datasource/product/product_model.dart';
import 'package:flutter_application_1/features/presentation/ui/home/product_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/config/router/route_constants.dart';
import '../../themes/app_styles.dart';
import '../../themes/app_spacing.dart';
import '../../themes/app_icons.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();
    final CartController cartController = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Product'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Get.toNamed(RouteConstants.cart);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Imagen del producto
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.4,
            ),
          ),
          // Contenedor con detalles del producto
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60.0),
                  topRight: Radius.circular(60.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 5,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: AppStyles.headline2,
                        ),
                      ),
                      Obx(() => QuantitySelector(
                            quantity: productController.selectedQuantity.value,
                            maxQuantity: product.stock,
                            onIncrement: () {
                              if (productController.selectedQuantity.value <
                                  product.stock) {
                                productController.selectedQuantity.value++;
                              }
                            },
                            onDecrement: () {
                              if (productController.selectedQuantity.value >
                                  1) {
                                productController.selectedQuantity.value--;
                              }
                            },
                          )),
                    ],
                  ),
                  AppSpacing.height8,
                  Text(
                    product.brand,
                    style: AppStyles.bodyText5,
                  ),
                  AppSpacing.height8,
                  Row(
                    children: [
                      const Icon(Icons.star, color: AppIcons.iconColorYellow),
                      AppSpacing.width4,
                      Text('${product.ratings} (320 Review)'),
                    ],
                  ),
                  AppSpacing.height8,
                  const Text(
                    'Available in stock',
                    style: TextStyle(color: AppIcons.iconColorGreen),
                  ),
                  AppSpacing.height16,
                  const Text(
                    'Color',
                    style: AppStyles.bodyText3,
                  ),
                  AppSpacing.height8,
                  Obx(
                    () => Row(
                      children: product.colors.map((color) {
                        bool isSelected =
                            color == productController.selectedColor.value;
                        return GestureDetector(
                          onTap: () {
                            productController.selectedColor.value = color;
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Color(productController.colorMap[color] ??
                                  0xFF000000),
                              shape: BoxShape.circle,
                              border: isSelected
                                  ? Border.all(color: Colors.red, width: 2)
                                  : null,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  AppSpacing.height16,
                  const Text(
                    'Description',
                    style: AppStyles.bodyText3,
                  ),
                  AppSpacing.height8,
                  Text(
                    product.description,
                    style: AppStyles.bodyText4,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '\$',
                        style: AppStyles.headline2.copyWith(color: AppColors.primary),
                      ),
                      Text(
                        '${product.price}',
                        style: AppStyles.headline2,
                      ),
                      const Spacer(),
                      CustomElevatedButton(
                        text: 'Add to Cart',
                        onPressed: () {
                          if (productController
                              .selectedColor.value.isNotEmpty) {
                            cartController.addItem(CartItem(
                              id: product.id,
                              name: product.name,
                              imageUrl: product.imageUrl,
                              color: productController.selectedColor.value,
                              price: product.price,
                              quantity:
                                  productController.selectedQuantity.value,
                              maxQuantity: product.stock,
                            ));
                            Get.snackbar('Success', 'Product added to cart',
                                snackPosition: SnackPosition.BOTTOM);
                          } else {
                            Get.snackbar('Error', 'Please select a color',
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
