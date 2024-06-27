import 'package:flutter_application_1/features/presentation/ui/main/carousel_controller.dart';
import 'package:get/get.dart';

class CarouselBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyCarouselController>(() => MyCarouselController());
  }
}