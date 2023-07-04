import 'package:shop_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:shop_app/app/modules/auth/repositories/auth_repository.dart';
import 'package:shop_app/app/modules/cart/controllers/cart_controller.dart';

import 'app/core/utils/app_colors.dart';
import 'app/core/utils/app_strings.dart';
import 'app/modules/admin_order/controllers/admin_order_controller.dart';
import 'app/modules/admin_order/repositories/admin_order_repository.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopApp extends StatelessWidget {
  ShopApp({
    Key? key,
  }) : super(key: key);

  String initRoute() {
    if (Get.find<AuthRepository>().getUserType() == "admin") {
      return Routes.ADMIN_NAVIGATOR;
    } else {
      return Routes.USER_NAVIGATOR;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Get.find<AuthRepository>().userLoggedIn()) {
      Get.find<AuthController>().getUserData();
    }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.APP_NAME,
      theme: ThemeData(
        primaryColor: AppColors.mainColor,
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.mainColor,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
      ),
      initialRoute: initRoute(),
      getPages: AppPages.routes,
    );
  }
}
