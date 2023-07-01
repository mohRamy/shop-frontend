import 'dart:convert';
import 'dart:io';

import 'package:shop_app/app/core/utils/app_colors.dart';
import 'package:shop_app/app/core/utils/components/components.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/constants/error_handling.dart';
import '../../../models/admin_model.dart';
import '../../../models/order_model.dart';
import '../../../models/product_model.dart';
import '../../../routes/app_pages.dart';
import '../repositories/admin_repository.dart';

class AdminController extends GetxController implements GetxService {
  final AdminRepository adminRepository;
  AdminController({
    required this.adminRepository,
  });

  List<ProductModel> products = [];
  List<OrderModel> orders = [];
  List<ProductModel>? productCategory = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final TextEditingController productNameC = TextEditingController();
  final TextEditingController descriptionC = TextEditingController();
  final TextEditingController priceC = TextEditingController();
  final TextEditingController quantityC = TextEditingController();

  final TextEditingController productNameUC = TextEditingController();
  final TextEditingController descreptionUC = TextEditingController();
  final TextEditingController priceUC = TextEditingController();
  final TextEditingController quantityUC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    productNameC.dispose();
    descriptionC.dispose();
    priceC.dispose();
    quantityC.dispose();
    productNameUC.dispose();
    descreptionUC.dispose();
    priceUC.dispose();
    quantityUC.dispose();
  }

  void addProduct({
    required String name,
    required String description,
    required int price,
    required int quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');
      List<String> imageUrl = [];
      for (var i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            images[i].path,
            folder: name,
          ),
        );
        imageUrl.add(res.secureUrl);
      }

      ProductModel product = ProductModel(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrl,
        category: category,
        price: price,
        oldPrice: 0,
      );

      http.Response res = await adminRepository.addProduct(
        product: product,
      );

      httpErrorHandle(
        res: res,
        onSuccess: () {
          Components.showCustomSnackBar(
            "Product Added Successfully!",
            title: "Product",
            color: AppColors.mainColor,
          );
          Get.back();
        },
      );
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  void fetchAllProducts() async {
    try {
      _isLoading = true;
      update();
      http.Response res = await adminRepository.fetchAllProducts();

      httpErrorHandle(
        res: res,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            products.add(
              ProductModel.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
      _isLoading = false;
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  void fetchCategoryProduct({
    required String category,
  }) async {
    try {
      _isLoading = true;
      update();
      http.Response res =
          await adminRepository.fetchCategoryProduct(category: category);

      httpErrorHandle(
        res: res,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            productCategory!.add(
              ProductModel.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
      _isLoading = false;
      update();
    } catch (e) {
      Get.snackbar('', e.toString());
    }
  }

  void deleteProduct({
    required ProductModel product,
    required VoidCallback onSuccess,
  }) async {
    try {
      http.Response res = await adminRepository.deleteProduct(product: product);

      httpErrorHandle(
        res: res,
        onSuccess: onSuccess,
      );
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  void updateProduct({
    required String id,
    required String name,
    required String description,
    required int price,
    required int quantity,
  }) async {
    try {
      http.Response res = await adminRepository.updateProduct(
        id: id,
        name: name,
        description: description,
        price: price,
        quantity: quantity,
      );

      httpErrorHandle(
        res: res,
        onSuccess: () {
          Components.showCustomSnackBar(
            'Update Seccessfully',
            title: 'Update',
            color: AppColors.mainColor,
          );
          Get.back();
        },
      );
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  int currentStep = 0;

  void changeOrderStatus({
    required int status,
    required OrderModel order,
  }) async {
    try {
      http.Response res =
          await adminRepository.changeOrderStatus(status: status, order: order);

      httpErrorHandle(
        res: res,
        onSuccess: () {
          currentStep += 1;
        },
      );
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  void deleteOrder({
    required OrderModel order,
  }) async {
    try {
      http.Response res = await adminRepository.deleteOrder(order: order);

      httpErrorHandle(
        res: res,
        onSuccess: () {
          Get.toNamed(Routes.ADMIN_NAVIGATOR);
        },
      );
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  Future<Map<String, dynamic>> fetchEarnings() async {
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response res = await adminRepository.fetchEarnings();

      httpErrorHandle(
        res: res,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarnings'];
          sales = [
            Sales('Mobiles', response['mobileEarnings']),
            Sales('Essentials', response['essentialEarnings']),
            Sales('Books', response['booksEarnings']),
            Sales('Appliances', response['applianceEarnings']),
            Sales('Fashion', response['fashionEarnings']),
          ];
        },
      );
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }

  @override
  void onInit() {
    fetchAllProducts();
    super.onInit();
  }
}