import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final RxBool isObscure = true.obs;

    return TextFormField(
      controller: controller,
      obscureText: isPassword ? isObscure.value : false,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        suffixIcon: isPassword
            ? Obx(() => IconButton(
                  icon: Icon(
                    isObscure.value ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    isObscure.value = !isObscure.value;
                  },
                ))
            : null,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
    );
  }
}
