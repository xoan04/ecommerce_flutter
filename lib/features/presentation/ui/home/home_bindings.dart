import 'package:flutter_application_1/features/presentation/ui/home/home_carousel_controller.dart';
import 'package:flutter_application_1/features/presentation/ui/profile/profile_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<HomeCarouselController>(
      () => HomeCarouselController(),
    );
  }
}
