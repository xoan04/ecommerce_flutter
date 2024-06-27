import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/config/core/assets.dart';

class MyCarouselController extends GetxController {
  final imgList = [
    Assets.imageMain1,
    Assets.imageMain2,
    Assets.imageMain4,
  ];

  final List<String> titles = [
    'Various Collections Of The Latest Products',
    'Complete Collection Of Color And Sizes',
    'Find The Most Suitable Outfit For you',
  ];

  final List<String> descriptions = [
    'Urna amet,suspendisse ullamcorper ac elit diam facilisis cursus vestibulum',
    'Urna amet,suspendisse ullamcorper ac elit diam facilisis cursus vestibulum',
    'Urna amet,suspendisse ullamcorper ac elit diam facilisis cursus vestibulum',
  ];

  var currentIndex = 0.obs;
  final CarouselController carouselController = CarouselController();

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    currentIndex.value = index;
  }
}
