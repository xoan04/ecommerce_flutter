import 'package:flutter_application_1/config/router/route_constants.dart';
import 'package:flutter_application_1/features/presentation/ui/home/home_bindings.dart';
import 'package:flutter_application_1/features/presentation/ui/home/home_screen.dart';
import 'package:flutter_application_1/features/presentation/ui/main/carousel_bindings.dart';
import 'package:flutter_application_1/features/presentation/ui/main/main_screen.dart';
import 'package:flutter_application_1/features/presentation/ui/login/login_bindings.dart';
import 'package:flutter_application_1/features/presentation/ui/login/login_screen.dart';
import 'package:flutter_application_1/features/presentation/ui/profile/profile_bindings.dart';
import 'package:flutter_application_1/features/presentation/ui/profile/profile_screen.dart';
import 'package:flutter_application_1/features/presentation/ui/register/register_bindings.dart';
import 'package:flutter_application_1/features/presentation/ui/register/register_screen.dart';
import 'package:flutter_application_1/features/presentation/ui/remember/forgot_password_bindings.dart';
import 'package:flutter_application_1/features/presentation/ui/remember/forgot_password_screen.dart';
import 'package:flutter_application_1/features/presentation/ui/splash/splash_screen.dart';
import 'package:flutter_application_1/features/presentation/ui/cart/cart_screen.dart';
import 'package:flutter_application_1/features/presentation/ui/products/filtered_products_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: RouteConstants.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: RouteConstants.main,
      page: () => MainScreen(),
      binding: CarouselBinding(),
    ),
    GetPage(
      name: RouteConstants.register,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: RouteConstants.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: RouteConstants.forgotPassword,
      page: () => ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: RouteConstants.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RouteConstants.profile,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: RouteConstants.cart,
      page: () => CartScreen(),
    ),
    GetPage(
      name: RouteConstants.filteredProducts,
      page: () => FilteredProductsScreen(),
    ),
  ];
}
