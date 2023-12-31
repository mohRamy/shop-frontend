import 'package:get_storage/get_storage.dart';

import '../../models/user_model.dart';

class UserLocal {
  final _getStorage = GetStorage();
  final typeKey = 'type';
  final tokenKey = 'token';
  final userIdKey = 'userId';
  final userKey = 'user-local';

  void saveUser(UserModel user) async {
    _getStorage.write(userKey, user.toJson());
  }

  UserModel? getUser() {
    var rawData = _getStorage.read(userKey);
    if (rawData != null) {
      return UserModel.fromJson(rawData);
    }
    return null;
  }

  void saveAccessToken(String token) async {
    _getStorage.write(tokenKey, token);
  }

  String getAccessToken() {
    return _getStorage.read(tokenKey) ?? '';
  }

  void clearAccessToken() async {
    _getStorage.remove(tokenKey);
  }

  void saveUserId(String userId) async {
    _getStorage.write(userIdKey, userId);
  }

  String getUserId() {
    return _getStorage.read(userIdKey) ?? '';
  }

  void saveUserType(String type) async {
    _getStorage.write(typeKey, type);
  }
  
  String getUserType() {
    return _getStorage.read(typeKey) ?? '';
  }

  void clearUserType() async {
    _getStorage.remove(typeKey);
  }
}
