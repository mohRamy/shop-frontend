import 'package:shop_app/app/core/utils/app_colors.dart';
import 'package:shop_app/app/core/utils/components/components.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:shop_app/app/modules/cart/repositories/cart_repository.dart';
import 'package:shop_app/app/modules/checkout/repositories/checkout_repository.dart';

import '../../../core/utils/constants/error_handling.dart';
import '../../../routes/app_pages.dart';

class CheckoutController extends GetxController implements GetxService {
  final CheckoutRepository orderRepository;
  CheckoutController({
    required this.orderRepository,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void checkout({
    required List<String> productsId,
    required List<int> userQuants,
    required int totalPrice,
    required String address,
  }) async {
    try {
      _isLoading = true;
      update();
      http.Response res = await orderRepository.checkout(
        productsId: productsId,
        userQuants: userQuants,
        totalPrice: totalPrice,
        address: address,
      );
      

      httpErrorHandle(
        res: res,
        onSuccess: () {
          Get.find<CartRepository>().removeCart();
          Components.showCustomSnackBar(
            'add Order Successed',
            title: 'Order',
            color: AppColors.mainColor,
          );
          Get.toNamed(Routes.USER_NAVIGATOR);
        },
      );
      _isLoading = false;
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }
}