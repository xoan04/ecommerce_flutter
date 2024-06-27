import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/router/route_constants.dart';
import 'package:flutter_application_1/features/presentation/ui/main/carousel_controller.dart';
import 'package:flutter_application_1/features/presentation/ui/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_styles.dart';
import '../../themes/app_spacing.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyCarouselController carouselCtrl = Get.put(MyCarouselController());
    final User? user = FirebaseAuth.instance.currentUser;

    // Redirigir al HomeScreen si el usuario está logueado
    if (user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(RouteConstants.home);
      });
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Contenedor para el carrusel de imágenes
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8, // Ancho fijo
              height: 300.0, // Altura fija para el carrusel
              child: CarouselSlider(
                items: carouselCtrl.imgList
                    .map((item) => Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35.0),
                            child: Image.asset(
                              item,
                              fit: BoxFit.cover,
                              width: 1500,
                              height: 900,
                              alignment: Alignment.topCenter, // Enfocar en la parte superior de la imagen
                            ),
                          ),
                        ))
                    .toList(),
                carouselController: carouselCtrl.carouselController,
                options: CarouselOptions(
                  height: 300.0, // Altura fija para el carrusel
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  viewportFraction: 1.0, // Cada imagen ocupa el 100% del espacio
                  onPageChanged: carouselCtrl.onPageChanged,
                ),
              ),
            ),
            AppSpacing.height20, // Añadir espacio entre el carrusel y el título
            // Contenedor para el título, descripción y puntos
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8, // Ancho fijo
              height: 190.0, // Altura fija para el título, descripción y puntos
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: Text(
                        carouselCtrl.titles[carouselCtrl.currentIndex.value],
                        key: ValueKey<int>(carouselCtrl.currentIndex.value),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center, // Centrar el texto
                        style: AppStyles.headline2,
                      ),
                    ),
                  ),
                  AppSpacing.height10, // Añadir espacio entre el título y la descripción
                  Obx(
                    () => AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: ConstrainedBox(
                        key: ValueKey<int>(carouselCtrl.currentIndex.value),
                        constraints: BoxConstraints(
                          maxHeight: 80.0, // Limitar la altura del texto de descripción
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            carouselCtrl.descriptions[carouselCtrl.currentIndex.value],
                            maxLines: 4, // Incrementar el número de líneas
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center, // Centrar el texto
                            style: AppStyles.bodyText1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.height10, // Añadir espacio entre la descripción y los puntos
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: carouselCtrl.imgList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => carouselCtrl.carouselController.animateToPage(entry.key),
                            child: Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness == Brightness.dark ? AppColors.white : Colors.black).withOpacity(
                                    carouselCtrl.currentIndex.value == entry.key ? 0.9 : 0.4),
                              ),
                            ),
                          );
                        }).toList(),
                      )),
                ],
              ),
            ),
            AppSpacing.height50, // Añadir espacio entre los puntos y los botones

            // Contenedor para los botones
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8, // Ancho fijo
              height: 100.0, // Altura fija para el botón y el texto
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                    text: 'Create Account',
                    onPressed: () {
                      Get.toNamed(RouteConstants.register);
                    },
                  ),
                  AppSpacing.height10,
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteConstants.login);
                    },
                    child: Text(
                      'Already Have an Account',
                      style: AppStyles.bodyText2,
                      textAlign: TextAlign.center, // Centrar el texto
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
