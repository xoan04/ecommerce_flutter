import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/features/presentation/ui/profile/profile_controller.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_styles.dart';
import '../../themes/app_spacing.dart';
import '../../themes/app_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ProfileController profileController;

  const CustomAppBar({Key? key, required this.profileController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          children: [
            Obx(() {
              final imageUrl = profileController.userData.value?.imageUrl ??
                  'https://via.placeholder.com/150';
              return CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                radius: 20,
              );
            }),
            AppSpacing.width10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  final nombre = profileController.userData.value?.firstName ?? 'User';
                  return Text(
                    'Hi, $nombre',
                    style: AppStyles.greetingText,
                  );
                }),
                Row(
                  children: [
                    const Icon(
                      Icons.monetization_on,
                      color: AppColors.primary,
                      size: AppIcons.size24,
                    ),
                    AppSpacing.width5,
                    Obx(() {
                      final cash = profileController.userData.value?.cash ?? 0;
                      return Text(
                        profileController.formatCash(cash),
                        style: AppStyles.cashText,
                      );
                    }),
                  ],
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.search, size: AppIcons.size30),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.notifications, size: AppIcons.size30),
              onPressed: () {},
            ),
          ],
        ),
      ),
      toolbarHeight: 130.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(130.0);
}
