import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/presentation/ui/register/register_controller.dart';
import 'package:flutter_application_1/features/presentation/ui/widgets/custom_elevated_button.dart';
import 'package:flutter_application_1/features/presentation/ui/widgets/custom_text_form_field.dart';
import 'package:flutter_application_1/features/presentation/utils/regexInput.dart';

import 'package:get/get.dart';
import '../../themes/app_styles.dart';
import '../../themes/app_spacing.dart';
import '../../themes/app_icons.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.find<RegisterController>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Register'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Create Account',
                  style: AppStyles.headline1,
                ),
                AppSpacing.height10,
                Text(
                  'Start learning with create your account',
                  style: AppStyles.bodyText5,
                ),
                AppSpacing.height30,
                Text(
                  'First Name',
                  style: AppStyles.bodyText3,
                ),
                AppSpacing.height10,
                CustomTextFormField(
                  controller: controller.firstNameController,
                  hintText: 'Enter your first name',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                AppSpacing.height20,
                Text(
                  'Last Name',
                  style: AppStyles.bodyText3,
                ),
                AppSpacing.height10,
                CustomTextFormField(
                  controller: controller.lastNameController,
                  hintText: 'Enter your last name',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                AppSpacing.height20,
                Text(
                  'Email',
                  style: AppStyles.bodyText3,
                ),
                AppSpacing.height10,
                CustomTextFormField(
                  controller: controller.emailController,
                  hintText: 'Enter your email',
                  icon: Icons.email,
                  validator: RegexInput.validateEmail,
                ),
                AppSpacing.height20,
                Text(
                  'Password',
                  style: AppStyles.bodyText3,
                ),
                AppSpacing.height10,
                CustomTextFormField(
                  controller: controller.passwordController,
                  hintText: 'Create your password',
                  icon: Icons.lock,
                  isPassword: true,
                  validator: RegexInput.validatePassword,
                ),
                AppSpacing.height10,
                Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPasswordCriteria(
                          text: 'At least one uppercase letter',
                          isValid: controller.hasUpperCase.value,
                        ),
                        _buildPasswordCriteria(
                          text: 'At least one number',
                          isValid: controller.hasDigit.value,
                        ),
                        _buildPasswordCriteria(
                          text: 'At least one special character',
                          isValid: controller.hasSpecialCharacter.value,
                        ),
                        _buildPasswordCriteria(
                          text: 'At least 7 characters long',
                          isValid: controller.hasMinLength.value,
                        ),
                      ],
                    )),
                AppSpacing.height30,
                Center(
                  child: CustomElevatedButton(
                    text: 'Create Account',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        controller.register();
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

  Widget _buildPasswordCriteria({required String text, required bool isValid}) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check : Icons.close,
          color: isValid ? AppIcons.iconColorGreen : AppIcons.iconColorRed,
        ),
        AppSpacing.width10,
        Text(text),
      ],
    );
  }
}
