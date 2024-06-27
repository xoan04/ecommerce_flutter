import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/core/assets.dart';
import 'package:flutter_application_1/config/router/route_constants.dart';
import 'package:flutter_application_1/features/presentation/themes/app_colors.dart';
import 'package:flutter_application_1/features/presentation/themes/app_spacing.dart';
import 'package:flutter_application_1/features/presentation/themes/app_styles.dart';
import 'package:flutter_application_1/features/presentation/ui/home/home_carousel_controller.dart';
import 'package:flutter_application_1/features/presentation/ui/products/products_detail_screen.dart';
import 'package:flutter_application_1/features/presentation/ui/profile/profile_controller.dart';
import 'package:flutter_application_1/features/presentation/ui/widgets/buttom_Navigation_Bar.dart';
import 'package:flutter_application_1/features/presentation/ui/widgets/logout_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/features/presentation/ui/home/product_controller.dart';
import 'package:flutter_application_1/features/presentation/ui/widgets/custom_app_bar.dart';
import 'package:flutter_application_1/features/presentation/ui/cart/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    if (index == 2) {
      Get.snackbar(
        'Vista en construcción',
        'Esta vista aun no está disponible.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (index == 3) {
      Get.toNamed(RouteConstants.profile);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  Future<void> _refresh() async {
    final ProductController productController = Get.find<ProductController>();
    await productController.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    final HomeCarouselController carouselCtrl =
        Get.find<HomeCarouselController>();
    final ProductController productController = Get.put(ProductController());

    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return LogoutDialog();
          },
        );
        return false;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: CustomAppBar(profileController: profileController),
          body: IndexedStack(
            index: _currentIndex,
            children: [
              Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'Home'),
                      Tab(text: 'Category'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        RefreshIndicator(
                          onRefresh: _refresh,
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                AppSpacing.height10,
                                CarouselSlider(
                                  items: carouselCtrl.imgList
                                      .map(
                                        (item) => Center(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              item,
                                              fit: BoxFit.cover,
                                              width: 1000,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  carouselController:
                                      carouselCtrl.carouselController,
                                  options: CarouselOptions(
                                    height: 200.0,
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    aspectRatio: 2.0,
                                    onPageChanged: carouselCtrl.onPageChanged,
                                  ),
                                ),
                                AppSpacing.height10,
                                const Text(
                                  '24% off shipping today on bag purchases',
                                  style: AppStyles.bodyText3,
                                ),
                                Obx(
                                  () => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: carouselCtrl.imgList
                                        .asMap()
                                        .entries
                                        .map(
                                      (entry) {
                                        return GestureDetector(
                                          onTap: () => carouselCtrl
                                              .carouselController
                                              .animateToPage(entry.key),
                                          child: Container(
                                            width: 8.0,
                                            height: 8.0,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 2.0),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: (Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? AppColors.white
                                                      : AppColors.primary)
                                                  .withOpacity(carouselCtrl
                                                              .currentIndex
                                                              .value ==
                                                          entry.key
                                                      ? 0.9
                                                      : 0.4),
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                                AppSpacing.height20,
                                const Text(
                                  'Last Products',
                                  style: AppStyles.headline2,
                                ),
                                AppSpacing.height10,
                                Obx(() {
                                  if (productController.isLoading.value) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  return GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(10.0),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 0.65,
                                    ),
                                    itemCount:
                                        productController.products.length,
                                    itemBuilder: (context, index) {
                                      final product =
                                          productController.products[index];
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(() => ProductDetailScreen(
                                                product: product));
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius
                                                          .vertical(
                                                          top: Radius.circular(
                                                              10.0)),
                                                  child: Image.network(
                                                    product.imageUrl,
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      product.name,
                                                      style:
                                                          AppStyles.bodyText3,
                                                    ),
                                                    AppSpacing.height5,
                                                    Text(
                                                      product.brand,
                                                      style:
                                                          AppStyles.bodyText4,
                                                    ),
                                                    AppSpacing.height5,
                                                    Text(
                                                      '\$${product.price}',
                                                      style:
                                                          AppStyles.bodyText3,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Obx(() {
                            if (productController.isLoading.value) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(10.0),
                              itemCount: productController.categories.length,
                              itemBuilder: (context, index) {
                                String category = productController
                                    .categories.keys
                                    .elementAt(index);
                                int count =
                                    productController.categories[category]!;
                                String backgroundImage = productController
                                        .categoryBackgrounds[category] ??
                                    Assets.profile_default;
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(RouteConstants.filteredProducts,
                                        arguments: category);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 10.0),
                                    padding: const EdgeInsets.all(16.0),
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                        image: AssetImage(backgroundImage),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.5),
                                            BlendMode.darken),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          category,
                                          style: AppStyles.headline2
                                              .copyWith(color: AppColors.white),
                                        ),
                                        Text(
                                          '$count Products',
                                          style: AppStyles.bodyText2
                                              .copyWith(color: AppColors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const CartScreen(showBackButton: false),
              const Center(
                child: Text(
                    'Favorite View'), // Aquí puedes poner tu vista de favoritos
              ),
              const Center(
                child: Text(
                    'Profile View'), // Aquí puedes poner tu vista de perfil
              ),
            ],
          ),
          bottomNavigationBar: BottomNavBar(
            currentIndex: _currentIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
