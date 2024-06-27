import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/datasource/cart/cart_model.dart';
import 'package:flutter_application_1/features/presentation/ui/profile/profile_controller.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;
  var selectedItems = <CartItem>[].obs;
  var totalAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    ever(selectedItems, (_) => calculateTotalAmount());
  }

  void addItem(CartItem item) {
    cartItems.add(item);
  }

  void removeItem(CartItem item) {
    cartItems.remove(item);
    selectedItems.remove(item);
  }

  void clearCart() {
    cartItems.clear();
    selectedItems.clear();
  }

  void calculateTotalAmount() {
    totalAmount.value = selectedItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void toggleItemSelection(CartItem item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
  }

  void removeSelectedItems() {
    cartItems.removeWhere((item) => selectedItems.contains(item));
    selectedItems.clear();
  }

  void updateItemQuantity(CartItem item, int quantity) {
    final index = cartItems.indexWhere((cartItem) => cartItem.id == item.id);
    if (index != -1) {
      cartItems[index].quantity = quantity;
      cartItems.refresh();
      if (selectedItems.contains(item)) {
        selectedItems[selectedItems.indexWhere((selectedItem) => selectedItem.id == item.id)].quantity = quantity;
        selectedItems.refresh();
      }
    }
  }

  void showCheckoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Checkout'),
          content: Text('Total amount: \$${totalAmount.value.toStringAsFixed(2)}\nAre you sure you want to proceed?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                checkout();
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Future<void> checkout() async {
    final ProfileController profileController = Get.find<ProfileController>();

    if (profileController.userData.value != null) {
      double userCash = profileController.userData.value!.cash;

      if (userCash >= totalAmount.value) {
        userCash -= totalAmount.value;
        await profileController.updateUserCash(userCash);
        removeSelectedItems();
        await profileController.reloadUserData(); // Recargar datos del usuario después del checkout
        Get.snackbar('Success', 'Checkout successful');
      } else {
        Get.snackbar('Error', 'Not enough cash');
      }
    }
  }
}
