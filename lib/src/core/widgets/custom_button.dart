import 'package:flutter/material.dart';

import '../../utils/sizer_custom/sizer.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttomText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  const CustomButton({
    Key? key,
    this.onPressed,
    required this.buttomText,
    this.transparent = false,
    this.margin,
    this.height,
    this.width,
    this.fontSize,
    this.radius = 5,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButton = TextButton.styleFrom(
      backgroundColor: onPressed == null
          ? Theme.of(context).disabledColor
          : transparent
              ? Colors.transparent
              : Theme.of(context).primaryColor,
      minimumSize: Size(
        width ?? SizerUtil.width,
        height ?? 50.sp,
      ),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
    return Center(
      child: SizedBox(
        width: width ?? SizerUtil.width,
        height: height ?? 50.sp,
        child: TextButton(
          onPressed: onPressed,
          style: _flatButton,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null ? Padding(
                padding: EdgeInsets.only(right: 5.sp) ,
                child: Icon(icon, color: transparent?Theme.of(context).primaryColor:Theme.of(context).cardColor,),
                
                ):const SizedBox(),
                Text(buttomText,
                style: TextStyle(
                  fontSize: fontSize ?? 15.sp,
                  color: transparent?Theme.of(context).primaryColor:Theme.of(context).cardColor,
                ),),
            ],
          ),
          ),
      ),
    );
  }
}
