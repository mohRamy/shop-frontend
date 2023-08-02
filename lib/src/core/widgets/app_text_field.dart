import 'package:flutter/material.dart';
import 'package:shop_app/src/themes/app_colors.dart';
import 'package:shop_app/src/themes/app_decorations.dart';

import '../../utils/sizer_custom/sizer.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final Widget suffixIcon;
  final TextInputType keyboardType;
  final int maxLines;
  final bool isObscure;
  const AppTextField({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.icon,
    this.suffixIcon = const SizedBox(),
    this.keyboardType = TextInputType.name,
    this.maxLines = 1,
    this.isObscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.textfeild(context, Dimensions.radius15).decoration,
      child: TextField(
        maxLines: maxLines,
        minLines: 1,
        keyboardType: keyboardType,
        controller: textController,
        obscureText: isObscure ? true : false,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: colorPrimary,
          ),
          suffixIcon: suffixIcon,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
