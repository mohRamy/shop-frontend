import '../../../public/components.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as diox;

import '../../../routes/app_pages.dart';
import '../../cart/repositories/cart_repository.dart';
import '../repositories/checkout_repository.dart';
import '../../../themes/app_colors.dart';

import '../../../public/constants.dart';

class CheckoutController extends GetxController implements GetxService {
  final CheckoutRepository checkoutRepository;
  CheckoutController(this.checkoutRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Future<void> makePayment() async {
  //   final transactionResult = await PayPalManager.makePayment('USD', 100.0);

  //   if (transactionResult.status == PayPalStatus.success) {
  //     // Payment successful, handle success scenario
  //     print('Payment successful! Transaction ID: ${transactionResult.transactionId}');
  //   } else if (transactionResult.status == PayPalStatus.cancelled) {
  //     // Payment cancelled by user, handle cancellation scenario
  //     print('Payment cancelled by user.');
  //   } else {
  //     // Payment failed, handle failure scenario
  //     print('Payment failed. Error message: ${transactionResult.errorMessage}');
  //   }
  // }

  void checkout({
    required List<String> productsId,
    required List<int> userQuants,
    required int totalPrice,
    required String address,
  }) async {
    try {
      diox.Response response = await checkoutRepository.checkout(
        productsId: productsId,
        userQuants: userQuants,
        totalPrice: totalPrice,
        address: address,
      );
      AppConstants.handleApi(
        response: response,
        onSuccess: () {
          Get.find<CartRepository>().addToCartHistoryList();
          Components.showSnackBar(
            'add Order Successed',
            title: 'Order',
            color: colorPrimary,
          );
          AppNavigator.popUntil(AppRoutes.NAVIGATION);
          update();
        },
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString(), title: "Checkout Order");
    }
  }
}
