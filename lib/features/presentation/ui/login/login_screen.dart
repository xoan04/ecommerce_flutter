import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/presentation/ui/login/login_controller.dart';
import 'package:flutter_application_1/features/presentation/ui/widgets/custom_elevated_button.dart';
import 'package:flutter_application_1/features/presentation/ui/widgets/custom_text_form_field.dart';
import 'package:flutter_application_1/features/presentation/utils/regexInput.dart';

import 'package:get/get.dart';
import 'package:flutter_application_1/config/router/route_constants.dart';
import '../../themes/app_styles.dart';
import '../../themes/app_spacing.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find<LoginController>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Login Account',
                  style: AppStyles.headline1,
                ),
                AppSpacing.height10,
                Text(
                  'Please login with registered account',
                  style: AppStyles.bodyText4,
                ),
                AppSpacing.height30,
                CustomTextFormField(
                  controller: controller.emailController,
                  hintText: 'Enter your email or phone number',
                  icon: Icons.email,
                  validator: RegexInput.validateEmail,
                ),
                AppSpacing.height20,
                CustomTextFormField(
                  controller: controller.passwordController,
                  hintText: 'Enter your password',
                  icon: Icons.lock,
                  isPassword: true,
                  validator: RegexInput.validatePassword,
                ),
                AppSpacing.height10,
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteConstants.forgotPassword);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: AppStyles.linkText,
                    ),
                  ),
                ),
                AppSpacing.height30,
                Center(
                  child: CustomElevatedButton(
                    text: 'Sign In',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        controller.login();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
