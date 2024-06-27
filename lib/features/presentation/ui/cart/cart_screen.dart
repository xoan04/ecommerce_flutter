import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/features/presentation/ui/cart/cart_controller.dart';
import 'package:flutter_application_1/features/presentation/ui/widgets/quantity_selector.dart';
import 'package:flutter_application_1/features/presentation/ui/widgets/custom_elevated_button.dart';
import '../../themes/app_styles.dart';
import '../../themes/app_spacing.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              cartController.removeSelectedItems();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return const Center(
            child: Text('Your cart is empty'),
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartController.cartItems[index];
                  return Obx(() => Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: cartController.selectedItems.contains(item),
                            onChanged: (bool? value) {
                              cartController.toggleItemSelection(item);
                            },
                          ),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  item.imageUrl,
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                              AppSpacing.width10,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: AppStyles.bodyText3,
                                    ),
                                    AppSpacing.height5,
                                    Text(
                                      'Color: ${item.color}',
                                      style: AppStyles.bodyText4,
                                    ),
                                    AppSpacing.height5,
                                    Row(
                                      children: [
                                        QuantitySelector(
                                          quantity: item.quantity,
                                          maxQuantity:
                                              10, // Set the maximum quantity according to your logic
                                          onIncrement: () =>
                                              cartController.updateItemQuantity(
                                                  item, item.quantity + 1),
                                          onDecrement: () =>
                                              cartController.updateItemQuantity(
                                                  item, item.quantity - 1),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '\$${item.price.toStringAsFixed(2)}',
                                          style: AppStyles.bodyText3,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: AppStyles.headline3,
                      ),
                      Obx(() {
                        final total = cartController.totalAmount.value;
                        return Text(
                          '\$${total.toStringAsFixed(2)}',
                          style: AppStyles.headline3,
                        );
                      }),
                    ],
                  ),
                  AppSpacing.height20,
                  CustomElevatedButton(
                    text: 'Checkout',
                    onPressed: () {
                      cartController.showCheckoutDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
