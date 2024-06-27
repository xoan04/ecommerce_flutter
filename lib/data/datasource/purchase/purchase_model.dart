import 'package:cloud_firestore/cloud_firestore.dart';

class Purchase {
  final String id;
  final String userId;
  final String productId;
  final DateTime purchaseDate;

  Purchase({
    required this.id,
    required this.userId,
    required this.productId,
    required this.purchaseDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'idpersona': userId,
      'idarticulo': productId,
      'fechacompra': purchaseDate,
    };
  }

  factory Purchase.fromMap(Map<String, dynamic> map) {
    return Purchase(
      id: map['id'] as String,
      userId: map['idpersona'] as String,
      productId: map['idarticulo'] as String,
      purchaseDate: (map['fechacompra'] as Timestamp).toDate(),
    );
  }
}
