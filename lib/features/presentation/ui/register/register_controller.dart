import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/presentation/utils/regexInput.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  var hasUpperCase = false.obs;
  var hasDigit = false.obs;
  var hasSpecialCharacter = false.obs;
  var hasMinLength = false.obs;

  @override
  void onInit() {
    super.onInit();
    passwordController.addListener(_validatePassword);
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
    firstNameController.dispose();
    lastNameController.dispose();
    super.onClose();
  }

  Future<void> register() async {
    try {
      // Registrar el usuario en Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      User? user = userCredential.user;

      if (user != null) {
        // Agregar el usuario en la colección de Firestore
        await _firestore.collection('usuario').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'imagen': '', // Puedes agregar la URL de la imagen si la tienes
          'nombre': firstNameController.text.trim(),
          'apellido': lastNameController.text.trim(),
          'rol': 'comprador', // Asignar rol por defecto
          'cash': 10000, // Valor inicial de cash
        });

        Get.snackbar('Success', 'Account created successfully');
        Get.offNamed('/home'); // Navegar a la pantalla principal
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
