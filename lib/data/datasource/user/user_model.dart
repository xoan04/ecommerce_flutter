class UserModel {
  final String uid;
  final String imageUrl;
  final String firstName;
  final String lastName;
  final String role;
  final double cash;
  final String email; // Agregar el campo email

  UserModel({
    required this.uid,
    required this.imageUrl,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.cash,
    required this.email, // Inicializar el campo email
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'imagen': imageUrl,
      'nombre': firstName,
      'apellido': lastName,
      'rol': role,
      'cash': cash,
      'email': email, // Añadir el campo email
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      imageUrl: map['imagen'] as String,
      firstName: map['nombre'] as String,
      lastName: map['apellido'] as String,
      role: map['rol'] as String,
      cash: map['cash'] as double,
      email: map['email'] as String, // Añadir el campo email
    );
  }

  // Método copyWith para copiar el modelo actual con modificaciones
  UserModel copyWith({
    String? uid,
    String? imageUrl,
    String? firstName,
    String? lastName,
    String? role,
    double? cash,
    String? email,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      imageUrl: imageUrl ?? this.imageUrl,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      role: role ?? this.role,
      cash: cash ?? this.cash,
      email: email ?? this.email,
    );
  }
}
