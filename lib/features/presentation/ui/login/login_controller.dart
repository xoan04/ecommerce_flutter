import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/presentation/utils/regexInput.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var hasUpperCase = false.obs;
  var hasDigit = false.obs;
  var hasSpecialCharacter = false.obs;
  var hasMinLength = false.obs;

  @override
  void onInit() {
    super.onInit();
    passwordController.addListener(_validatePassword);
    if (kDebugMode) {
      emailController.text = "juan@gmail.com";
      passwordController.text = "Locuxdark4@";
    }
  }

  void _validatePassword() {
    final password = passwordController.text;
    hasUpperCase.value = RegexInput.hasUpperCase(password);
    hasDigit.value = RegexInput.hasDigit(password);
    hasSpecialCharacter.value = RegexInput.hasSpecialCharacter(password);
    hasMinLength.value = RegexInput.hasMinLength(password);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Get.snackbar('Success', 'Logged in successfully');
      Get.offNamed('/home'); // Navegar a la pantalla principal
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
