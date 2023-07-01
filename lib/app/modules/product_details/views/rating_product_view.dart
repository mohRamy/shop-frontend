import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shop_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:shop_app/app/modules/product_details/controllers/product_details_controller.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/app_column.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../core/widgets/big_text.dart';
import '../../../core/widgets/expandable_text_widget.dart';
import '../../../controller/user_controller.dart';
import '../../../models/product_model.dart';
import '../../../models/rating_model.dart';
import '../../../routes/app_pages.dart';

class RatingProductView extends StatefulWidget {
  const RatingProductView({super.key});

  @override
  State<RatingProductView> createState() => _RatingProductViewState();
}

class _RatingProductViewState extends State<RatingProductView> {
  double _currPageValue = 0.0;
  PageController pageController = PageController();
  final double _height = Dimensions.pageView;
  final double _scaleFactor = 0.8;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ProductDetailsController productDetailsCtrl =
        Get.find<ProductDetailsController>();
    ProductModel product = Get.arguments[AppString.ARGUMENT_PRODUCT];
    List<RatingModel> ratings = Get.arguments[AppString.ARGUMENT_RATINGS];
    productDetailsCtrl.initProduct(product, Get.find<CartController>());
    double totalRating = 0;
    for (int i = 0; i < ratings.length; i++) {
      totalRating += ratings[i].rating;
      if (ratings[i].userId == Get.find<UserController>().user.id) {
        productDetailsCtrl.myRating.value = ratings[i].rating;
      }
    }

    if (totalRating != 0) {
      productDetailsCtrl.avgRating.value = totalRating / ratings.length;
    }

    return Scaffold(
      body: Stack(
        children: [
          product.images.length > 1
              ? Positioned(
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    height: Dimensions.pageView,
                    color: Colors.grey[100],
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: pageController,
                      itemCount: product.images.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(
                          position,
                          product.images[position],
                        );
                      },
                    ),
                  ),
                )
              : Positioned(
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    width: double.maxFinite,
                    height: Dimensions.ratingProductImgSize,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(product.images[0]),
                      ),
                    ),
                  ),
                ),
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    onTap: () => Get.back(),
                    icon: Icons.clear,
                  ),
                  GetBuilder<ProductDetailsController>(
                    builder: (controller) => Stack(
                      children: [
                        AppIcon(
                          onTap: () {
                            if (controller.totalItems != 0) {
                              Get.toNamed(Routes.CART);
                            }
                          },
                          icon: Icons.shopping_cart_outlined,
                        ),
                        controller.totalItems != 0
                            ? Positioned(
                                right: 0.0,
                                top: 0.0,
                                child: AppIcon(
                                  onTap: () {},
                                  icon: Icons.circle,
                                  size: 20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.mainColor,
                                ),
                              )
                            : Container(),
                        controller.totalItems != 0
                            ? Positioned(
                                right: 6.0,
                                top: 1.0,
                                child: BigText(
                                  text: Get.find<ProductDetailsController>()
                                      .totalItems
                                      .toString(),
                                  size: 12,
                                  color: Colors.white,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              )),
          productDetailsCtrl.avgRating.value != 0.0
              ? Positioned(
                  top: Dimensions.height10 * 26,
                  right: Dimensions.width20,
                  child: Obx(
                    () {
                      return Container(
                        padding: EdgeInsets.all(
                          Dimensions.width10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.starColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              offset: const Offset(0, 2),
                              color: Colors.grey.withOpacity(0.2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.black,
                              size: 20,
                            ),
                            Text(
                              productDetailsCtrl.avgRating.value.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              : Container(),

          product.images.length > 1
              ? Positioned(
                  top: Dimensions.height10 * 26,
                  right: 0.0,
                  left: 0.0,
                  child: DotsIndicator(
                    dotsCount:
                        product.images.isEmpty ? 1 : product.images.length,
                    position: _currPageValue.toInt(),
                    decorator: DotsDecorator(
                      activeColor: Colors.blue,
                      size: const Size.square(9.0),
                      activeSize: const Size(18.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                )
              : Container(),

          // body
          Positioned(
            top: Dimensions.ratingProductImgSize - 50,
            bottom: 0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.only(
                top: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20),
                  topRight: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(
                    text: product.name,
                    category: product.category,
                    price: product.price,
                    oldPrice: product.oldPrice,
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  BigText(
                    text: 'Introduce',
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ExpandableTextWidget(
                      text: product.description,
                    ),
                  )),
                  SizedBox(height: Dimensions.height10),
                  GetBuilder<ProductDetailsController>(builder: (productDetailsCtrl) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rate The Product:',
                          style: TextStyle(
                            fontSize: Dimensions.font16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RatingBar.builder(
                          itemSize: 20,
                          initialRating: productDetailsCtrl.myRating.value,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: AppColors.starColor,
                          ),
                          onRatingUpdate: (rating) {
                            productDetailsCtrl.rateProduct(
                              product: product,
                              rating: rating,
                            );
                          },
                        )
                      ],
                    );
                  }),
                  SizedBox(height: Dimensions.height10),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(
          top: Dimensions.height30,
          bottom: Dimensions.height30,
          right: Dimensions.width20,
          left: Dimensions.width20,
        ),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius20 * 2),
            topRight: Radius.circular(Dimensions.radius20 * 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: Dimensions.height15,
                bottom: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                color: Colors.white,
              ),
              child: Obx(
                () => Row(
                  children: [
                    InkWell(
                      onTap: () {
                        productDetailsCtrl.setQuantity(
                          false,
                          product.quantity,
                        );
                      },
                      child: Icon(
                        Icons.remove,
                        color: AppColors.signColor,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    BigText(text: productDetailsCtrl.quantity.toString()),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    InkWell(
                      onTap: () {
                        productDetailsCtrl.setQuantity(
                          true,
                          product.quantity,
                        );
                      },
                      child: Icon(
                        Icons.add,
                        color: AppColors.signColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppTextButton(
              txt: 'Add to Cart',
              onTap: () => productDetailsCtrl.addItem(product),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageItem(
    int index,
    String image,
  ) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currtrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currtrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currtrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(
          0,
          _height * (1 - _scaleFactor) / 2,
          1,
        );
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageView,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(Dimensions.radius15),
              color: index.isEven
                  ? const Color(0xFF69c5df)
                  : const Color(0xFF9294cc),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(image),
              ),
            ),
          ),
        ],
      ),
    );
  }
}