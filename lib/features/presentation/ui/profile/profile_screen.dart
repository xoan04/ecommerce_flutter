import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/core/assets.dart';
import 'package:flutter_application_1/features/presentation/themes/app_colors.dart';
import 'package:flutter_application_1/features/presentation/ui/profile/profile_controller.dart';
import 'package:flutter_application_1/features/presentation/ui/widgets/logout_dialog.dart';
import 'package:flutter_application_1/features/services/user_storage.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io'; // Para trabajar con la clase File
import 'package:flutter_application_1/config/router/route_constants.dart';
import '../../themes/app_styles.dart';
import '../../themes/app_spacing.dart';
import '../../themes/app_icons.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final UserStorage userStorage = UserStorage();

  Future<String?> getUserUID() async {
    return await userStorage.readUID();
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    if (FirebaseAuth.instance.currentUser == null) {
      // Si el usuario no está logueado, redirigir al login
      Future.microtask(
        () => Get.offNamed(
          RouteConstants.login,
        ),
      );
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return LogoutDialog();
                  },
                );
              },
            ),
          ],
        ),
        body: FutureBuilder<String?>(
          future: getUserUID(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final uid = snapshot.data ?? 'UID not found';

            return Obx(() {
              if (controller.isLoading == true) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: controller.pickProfileImage,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: controller.profileImagePath.value.isNotEmpty
                                ? FileImage(File(controller.profileImagePath.value))
                                : (controller.userData.value != null &&
                                        controller.userData.value!.imageUrl.isNotEmpty
                                    ? NetworkImage(controller.userData.value!.imageUrl)
                                    : const AssetImage(Assets.profile_default)) as ImageProvider,
                            child: controller.profileImagePath.value.isEmpty &&
                                    (controller.userData.value == null ||
                                        controller.userData.value!.imageUrl.isEmpty)
                                ? const Icon(Icons.camera_alt, size: 50, color: Colors.white)
                                : null,
                          ),
                          const CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.white,
                            child: Icon(Icons.edit, size: 20),
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.height20,
                    _buildProfileInfo(
                      icon: Icons.person,
                      label: 'Username',
                      value: controller.userData.value != null
                          ? "${controller.userData.value!.firstName} ${controller.userData.value!.lastName}"
                          : 'Loading...',
                    ),
                    AppSpacing.height20,
                    _buildProfileInfo(
                      icon: Icons.email,
                      label: 'Email',
                      value: controller.userData.value?.email ?? 'Loading...',
                    ),
                    AppSpacing.height20,
                    _buildProfileInfo(
                      icon: Icons.monetization_on,
                      label: 'Cash',
                      value: controller.userData.value != null
                          ? controller.formatCash(controller.userData.value!.cash)
                          : 'Loading...',
                    ),
                    AppSpacing.height20,
                    _buildProfileInfo(
                      icon: Icons.account_circle,
                      label: 'UID',
                      value: uid,
                    ),
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }

  Widget _buildProfileInfo({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppIcons.iconColor),
          AppSpacing.width10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppStyles.bodyText5,
                ),
                Text(
                  value,
                  style: AppStyles.bodyText6,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
