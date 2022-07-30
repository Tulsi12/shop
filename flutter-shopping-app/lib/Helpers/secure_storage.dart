
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageFrave {


  final secureStorage = FlutterSecureStorage();
  
  Future<void> persistenToken( String token ) async {
    await secureStorage.write(key: 'token', value: token);
  }

  Future<void> persistenRolId( String role ) async {
    await secureStorage.write(key: 'role', value: role);
  }

  Future<void> persistenUserId( String id ) async {
    await secureStorage.write(key: 'id', value: id);
  }

  Future<String?> readRolId() async {
    return await secureStorage.read(key: 'role');
  }

  Future<String?> readToken() async {
    return await secureStorage.read(key: 'token');
  }

  Future<String?> readUserId() async {
    return await secureStorage.read(key: 'id');
  }

  Future<void> deleteSecureStorage() async {
    await secureStorage.delete(key: 'token');
    await secureStorage.deleteAll();
  }



}

final secureStorage = SecureStorageFrave();