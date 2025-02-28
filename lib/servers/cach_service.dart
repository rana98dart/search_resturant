import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CachService {
  final storage = FlutterSecureStorage();
  Future<void> addtoken(String token) async {
    storage.write(key: 'token', value: token);
  }

  Future<String?> gettoken() async {
    return await storage.read(key: 'token');
  }

  Future<void> deletToken() async {
    storage.delete(key: 'token');
  }
}
