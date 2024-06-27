import 'package:flutter_application_1/data/datasource/user/user_model.dart';
import 'package:flutter_application_1/features/services/user_storage.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io'; // Para trabajar con la clase File

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  final UserStorage userStorage = UserStorage();

  Rx<User?> firebaseUser = Rx<User?>(null);
  Rx<UserModel?> userData = Rx<UserModel?>(null);
  Rx<String> profileImagePath = ''.obs;

  var isLoading = false;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.value = _auth.currentUser;
    if (firebaseUser.value != null) {
      loadUserData();
    }
  }

  Future<void> loadUserData() async {
    isLoading = true;
    DocumentSnapshot userDoc = await _firestore
        .collection('usuario')
        .doc(firebaseUser.value!.uid)
        .get();
    userData.value = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
    await userStorage.writeUID(userData.value!.uid);
    isLoading = false;
  }

  Future<void> pickProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImagePath.value = pickedFile.path;
      await _uploadProfileImage(File(pickedFile.path));
    }
  }

  Future<void> _uploadProfileImage(File imageFile) async {
    try {
      final ref = _storage
          .ref()
          .child('user_profile_images')
          .child('${firebaseUser.value!.uid}.jpg');
      await ref.putFile(imageFile);
      final imageUrl = await ref.getDownloadURL();

      await _firestore
          .collection('usuario')
          .doc(firebaseUser.value!.uid)
          .update({'imagen': imageUrl});
      userData.value = userData.value!.copyWith(imageUrl: imageUrl); // Actualizar el valor localmente

      Get.snackbar('Success', 'Profile image updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload profile image');
    }
  }

  Future<void> updateUserCash(double newCash) async {
    if (firebaseUser.value != null) {
      await _firestore
          .collection('usuario')
          .doc(firebaseUser.value!.uid)
          .update({'cash': newCash});
      userData.value = userData.value!.copyWith(cash: newCash); // Actualizar el valor localmente
      userData.refresh(); // Notificar a los observadores que los datos han cambiado
    }
  }

  Future<void> reloadUserData() async {
    if (firebaseUser.value != null) {
      await loadUserData();
    }
  }

  String formatCash(num cash) {
    return cash.toStringAsFixed(2);
  }
}
