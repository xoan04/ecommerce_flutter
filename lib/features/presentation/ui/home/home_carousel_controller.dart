import 'package:flutter_application_1/config/core/assets.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeCarouselController extends GetxController {
  final CarouselController carouselController = CarouselController();
  var currentIndex = 0.obs;

  final imgList = [
    Assets.imageCarouselMain,
    Assets.imageCarouselMain4,
    Assets.imageCarouselMain4,
  ];

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    currentIndex.value = index;
  }
}
