

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserStorage {
  // Crea una instancia de almacenamiento seguro
  final _storage = const FlutterSecureStorage();

  // Clave para acceder al UID
  final String _uidKey = 'user_uid';

  // Método para guardar el UID
  Future<void> writeUID(String uid) async {
    await _storage.write(key: _uidKey, value: uid);
  }

  // Método para leer el UID
  Future<String?> readUID() async {
    return await _storage.read(key: _uidKey);
  }

  // Método para eliminar el UID
  Future<void> deleteUID() async {
    await _storage.delete(key: _uidKey);
  }
}
