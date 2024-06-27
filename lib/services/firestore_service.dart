import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/data/datasource/product/product_model.dart';
import 'package:flutter_application_1/data/datasource/purchase/purchase_model.dart';
import 'package:flutter_application_1/data/datasource/user/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Añadir un producto
  // Future<void> addProduct(Product product) async {
  //   await _db.collection('productos').doc(product.id).set(product.toMap());
  // }

  // Obtener un producto por ID
  Future<ProductModel?> getProduct(String id) async {
    DocumentSnapshot doc = await _db.collection('productos').doc(id).get();
    if (doc.exists) {
      return ProductModel.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Obtener todos los productos
  Future<List<ProductModel>> getProducts() async {
    QuerySnapshot querySnapshot = await _db.collection('productos').get();
    return querySnapshot.docs.map((doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  // Añadir un usuario
  Future<void> addUser(UserModel user) async {
    await _db.collection('usuario').doc(user.uid).set(user.toMap());
  }

  // Obtener un usuario por UID
  Future<UserModel?> getUser(String uid) async {
    DocumentSnapshot doc = await _db.collection('usuario').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Añadir una compra
  Future<void> addPurchase(Purchase purchase) async {
    await _db.collection('compras').doc(purchase.id).set(purchase.toMap());
  }

  // Obtener una compra por ID
  Future<Purchase?> getPurchase(String id) async {
    DocumentSnapshot doc = await _db.collection('compras').doc(id).get();
    if (doc.exists) {
      return Purchase.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }
}
