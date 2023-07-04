import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/app/core/utils/app_colors.dart';
import 'package:shop_app/app/modules/auth/repositories/auth_repository.dart';

import '../../../core/utils/components/app_components.dart';

import '../../../core/api/api_client.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/constants/error_handling.dart';
import '../../../controller/user_controller.dart';
import '../../../helper/dependencies.dart' as dep;
import '../../../routes/app_pages.dart';

class AuthController extends GetxController implements GetxService {
  final ApiClient apiClient;
  final AuthRepository authRepository;
  SharedPreferences sharedPreferences;
  AuthController({
    required this.apiClient,
    required this.authRepository,
    required this.sharedPreferences,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TextEditingController emailIC = TextEditingController();
  TextEditingController passwordIC = TextEditingController();

  TextEditingController emailUC = TextEditingController();
  TextEditingController passwordUC = TextEditingController();
  TextEditingController nameUC = TextEditingController();
  TextEditingController phoneUC = TextEditingController();
  TextEditingController codeOtpUC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailIC.dispose();
    passwordIC.dispose();

    emailUC.dispose();
    passwordUC.dispose();
    nameUC.dispose();
    phoneUC.dispose();
    codeOtpUC.dispose();
  }

  void sendOtP({
    required String phoneCode,
    required String phoneNumber,
  }) async {
    try {
      await authRepository.sendOtP(phoneCode, phoneNumber);
      update();
    } catch (e) {
      AppComponents.showCustomSnackBar(e.toString());
    }
  }

  void signUpUser({
    required File? photo,
    required String name,
    required String email,
    required String password,
    required String phoneCode,
    required String phoneNumber,
    required String codeOTP,
  }) async {
    try {
      _isLoading = true;
      update();

      http.Response verifyRes =
          await authRepository.verifyOTP(phoneCode, phoneNumber, codeOTP);

      httpErrorHandle(
          res: verifyRes,
          onSuccess: () async {
            String photoCloud = '';
            if (photo != null) {
              final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');
              int random = Random().nextInt(1000);

              CloudinaryResponse res = await cloudinary.uploadFile(
                CloudinaryFile.fromFile(
                  photo.path,
                  folder: "$name $random",
                ),
              );
              photoCloud = res.secureUrl;
            } else {
              photoCloud = "https://asota.umobile.edu/wp-content/uploads/2021/08/Person-icon.jpeg";
            }

            http.Response res = await authRepository.signUpUser(
              photo: photoCloud,
              name: name,
              email: email,
              password: password,
              phone: phoneNumber,
            );

            httpErrorHandle(
              res: res,
              onSuccess: () {
                AppComponents.showCustomSnackBar(
                  title: 'Sign Up',
                  "Account created! Login with the same credentials!",
                  color: AppColors.mainColor,
                );
                emailUC.text = '';
                passwordUC.text = '';
                nameUC.text = '';
                phoneUC.text = '';
                Get.toNamed(Routes.SIGN_IN);
              },
            );
          });
    } catch (e) {
      AppComponents.showCustomSnackBar(e.toString());
    }
    _isLoading = false;
    update();
  }

  void signInUser(
    String email,
    String password,
  ) async {
    try {
      _isLoading = true;
      update();
      http.Response res = await authRepository.login(email, password);

      httpErrorHandle(
        res: res,
        onSuccess: () async {
          await dep.init();
          authRepository.saveUserToken(jsonDecode(res.body)['token']);
          Get.find<UserController>().setUserFromJson(res.body);
          sharedPreferences.setString(
              AppString.TYPE_KEY, jsonDecode(res.body)['type']);
          emailIC.text = '';
          passwordIC.text = '';
          if (Get.find<UserController>().user.type == 'user') {
            Get.put(UserController());
            Get.offNamedUntil(Routes.USER_NAVIGATOR, (route) => false);
          } else {
            Get.put(UserController());
            Get.offNamedUntil(Routes.ADMIN_NAVIGATOR, (route) => false);
          }
        },
      );
    } catch (e) {
      AppComponents.showCustomSnackBar(e.toString());
    }
    _isLoading = false;
    update();
  }

  void getUserData() async {
    try {
      _isLoading = true;
      update();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(AppString.TOKEN);

      if (token == null) {
        prefs.setString(AppString.TOKEN, '');
      }

      http.Response tokenRes = await authRepository.tokenIsValid();
      bool response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await authRepository.getUserData();

        UserController userController = Get.find<UserController>();
        userController.setUserFromJson(userRes.body);
      }
    } catch (e) {
      AppComponents.showCustomSnackBar(e.toString());
    }
    _isLoading = false;
    update();
  }

  bool userLoggedIn() {
    return authRepository.userLoggedIn();
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppString.TOKEN_KEY);
    apiClient.tokenKey = '';
    apiClient.updateHeaders('');
    return true;
  }

  bool isObscure = true;

  void changeObsure() {
    isObscure = !isObscure;
    update();
  }
}
