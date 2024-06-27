import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/config/router/route_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_styles.dart';
import '../../themes/app_spacing.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el entorno actual
    String env = dotenv.env['ENV'] ?? 'unknown';
    // Obtener el enlace adecuado según el entorno
    String apiUrl = env == 'development'
        ? dotenv.env['DEV_API_URL'] ?? 'No DEV_API_URL found'
        : dotenv.env['PROD_API_URL'] ?? 'No PROD_API_URL found';

    Future.delayed(const Duration(seconds: 3), () {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.offAllNamed(RouteConstants.main); // Navegar a la pantalla principal si el usuario no está logueado
      } else {
        Get.offAllNamed(RouteConstants.home); // Navegar a la pantalla de inicio si el usuario está logueado
      }
    });

    return Scaffold(
      backgroundColor: AppColors.primary, // Fondo morado
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Kutuku', // Texto en negrita
              style: AppStyles.headline1,
            ),
            AppSpacing.height10,
            const Text(
              'Any shopping just from home',
              style: AppStyles.bodyText1,
            ),
            AppSpacing.height20,
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.white), // Color del indicador de progreso
            ),
            AppSpacing.height20,
            Text(
              'Environment: $env',
              style: AppStyles.bodyText2,
            ),
            AppSpacing.height10,
            Text(
              'API URL: $apiUrl',
              style: AppStyles.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
