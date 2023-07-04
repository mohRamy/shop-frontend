import 'package:shop_app/app/controller/user_controller.dart';
import 'package:shop_app/app/core/utils/app_colors.dart';
import 'package:shop_app/app/core/utils/components/app_components.dart';
import 'package:shop_app/app/core/utils/dimensions.dart';
import 'package:shop_app/app/core/utils/hex_color.dart';
import 'package:shop_app/app/core/widgets/custom_button.dart';
import 'package:shop_app/app/core/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:shop_app/app/modules/checkout/controllers/checkout_controller.dart';

import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/big_text.dart';
import '../../../models/cart_model.dart';
import '../../../routes/app_pages.dart';
import '../widgets/items_widget.dart';
import '../widgets/radio_widget.dart';
enum Ordered {
  visa,
  googlePay,
  applePay,
  cashOnDelivery,
}

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  Ordered? _order = Ordered.visa;

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    CartController cartController = Get.find<CartController>();
    List<CartModel> getItems = cartController.getItems;

    List<int> userQuants = [];
    List<String> productsId = [];

    for (var i = 0; i < getItems.length; i++) {
      userQuants.add(getItems[i].userQuant!);
      productsId.add(getItems[i].id!);
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: Dimensions.height10 * 10,
            padding: EdgeInsets.only(
              top: Dimensions.height45,
              left: Dimensions.width20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  onTap: () => Get.back(),
                  icon: Icons.arrow_back_ios,
                  backgroundColor: AppColors.originColor,
                ),
                BigText(
                  text: 'Checkout',
                  color: Colors.white,
                ),
                Container(
                  width: Dimensions.height45,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(Dimensions.height10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shipping Address',
                        style: TextStyle(fontSize: Dimensions.iconSize16 + 2),
                      ),
                      SizedBox(height: Dimensions.height10),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.UPDATE_PROFILE),
                        child: Container(
                          padding: EdgeInsets.only(
                            right: Dimensions.width10,
                            left: Dimensions.width20,
                            top: Dimensions.width10,
                            bottom: Dimensions.width10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1,
                                offset: const Offset(0, 2),
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: Dimensions.radius20 + 5,
                                backgroundColor: HexColor('#FCF3CF'),
                                child: AppIcon(
                                  backgroundColor: AppColors.originColor,
                                  iconColor: Colors.white,
                                  onTap: () {},
                                  icon: Icons.location_on,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                ),
                              ),
                              SizedBox(width: Dimensions.width30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Home',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.height10 - 5),
                                  SizedBox(
                                    width: Dimensions.width10 * 50,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SmallText(
                                          overflow: TextOverflow.ellipsis,
                                          text: userController.user.phone,
                                        ),
                                        SmallText(
                                          overflow: TextOverflow.ellipsis,
                                          text: userController.user.address,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Icon(Icons.edit_note_outlined),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.height20),
                      Text(
                        'Payment Methods',
                        style: TextStyle(fontSize: Dimensions.iconSize16 + 2),
                      ),
                      SizedBox(height: Dimensions.height10),
                      RadioWidget(
                        image: 'assets/images/visa1.webp',
                        title: 'Visa Card',
                        radio: Radio<Ordered>(
                          activeColor: AppColors.originColor,
                          value: Ordered.visa,
                          groupValue: _order,
                          onChanged: (Ordered? val) {
                            setState(() {
                              _order = val;
                            });
                          },
                        ),
                      ),
                      RadioWidget(
                        image: 'assets/images/google.png',
                        title: 'Google Pay',
                        radio: Radio<Ordered>(
                          activeColor: AppColors.originColor,
                          value: Ordered.googlePay,
                          groupValue: _order,
                          onChanged: (Ordered? val) {
                            setState(() {
                              _order = val;
                            });
                          },
                        ),
                      ),
                      RadioWidget(
                        image: 'assets/images/apple.png',
                        title: 'Apple Pay',
                        radio: Radio<Ordered>(
                          activeColor: AppColors.originColor,
                          value: Ordered.applePay,
                          groupValue: _order,
                          onChanged: (Ordered? val) {
                            setState(() {
                              _order = val;
                            });
                          },
                        ),
                      ),
                      RadioWidget(
                        image: 'assets/images/cash-delivery.webp',
                        title: 'Cash on delivery',
                        radio: Radio<Ordered>(
                          activeColor: AppColors.originColor,
                          value: Ordered.cashOnDelivery,
                          groupValue: _order,
                          onChanged: (Ordered? val) {
                            setState(() {
                              _order = val;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: Dimensions.height20),
                      ItemsWidget(
                        txt: '${getItems.length.toString()} Items',
                        account: '\$ ${cartController.totalAmount.toString()}',
                      ),
                      const ItemsWidget(
                        txt: 'ShippingFee',
                        account: '\$ 100',
                      ),
                      cartController.totalOldAmount != 0 ?
                      ItemsWidget(
                        txt: 'Discount',
                        account: '\$ ${cartController.totalOldAmount - cartController.totalAmount}',
                      ) : Container(),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BigText(text: "Total"),
                          BigText(
                            text: '\$ ${cartController.totalAmount + 100}',
                            color: AppColors.originColor,
                            size: 22,
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.height30),
                      Container(
                        padding: EdgeInsets.only(
                          right: Dimensions.width20,
                          left: Dimensions.width20,
                          top: Dimensions.width30,
                          bottom: Dimensions.width30,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              offset: const Offset(0, 2),
                              color: Colors.grey.withOpacity(0.2),
                            ),
                          ],
                        ),
                        child:
                            GetBuilder<CheckoutController>(builder: (checkoutController) {
                          return CustomButton(
                            buttomText: 'Apply',
                            onPressed: () {
                              if (userController.user.address.isNotEmpty ||
                                  userController.user.phone.isNotEmpty) {
                                if (_order == Ordered.cashOnDelivery) {
                                  checkoutController.checkout(
                                    productsId: productsId,
                                    userQuants: userQuants,
                                    totalPrice: cartController.totalAmount,
                                    address: userController.user.address,
                                  );
                                }
                              } else {
                                AppComponents.showCustomSnackBar(
                                  'Your Data is not completed',
                                );
                              }
                            },
                          );
                        }),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
