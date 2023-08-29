import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../../themes/app_colors.dart';

class DialogNotice extends StatelessWidget {
  final String title;
  final String subTitle;

  const DialogNotice({required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.sp,
      height: 155.sp,
      padding: EdgeInsets.symmetric(vertical: 16.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 6.sp),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
            ),
          ),
          SizedBox(height: 10.sp),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 7.5.sp),
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10.5.sp),
            ),
          ),
          SizedBox(height: 8.sp),
          Divider(),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              color: Colors.transparent,
              width: 300.sp,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 5.sp),
              child: Text(
                'OK',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                  color: colorPrimary,
                ),
              ),
            ),
          ),
          Divider(color: Colors.grey),
        ],
      ),
    );
  }
}