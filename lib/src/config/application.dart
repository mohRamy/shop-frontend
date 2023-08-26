import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../services/firebase_messaging/handle_messaging.dart';

class Application {
  /// [Production - Dev]
  static String version = '1.0.0';
  static String baseUrl = '';
  static String imageUrl = '';
  static String socketUrl = '';
  static String mode = '';
  static bool isProductionMode = true;

  Future<void> initialAppLication() async {
    try {
      await GetStorage.init();
      baseUrl = 'http://192.168.138.79:3000';
      socketUrl = 'http://192.168.138.79:3000';
      mode = 'PRODUCTION';
      requestPermission();
      handleReceiveNotification();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  ///Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
