import 'package:flutter/material.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import '../../themes/app_colors.dart';

class NetworkError extends StatelessWidget {
  final Function loadData;
  final String message;
  final bool isSmall;

  const NetworkError(
      {required this.loadData, required this.message, this.isSmall = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/cloud_state.png",
            package: "flutter_paypal",
            height: 120.sp,
          ),
          SizedBox(
            height: isSmall ? 20 : 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$message",
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF272727),
                      fontWeight: FontWeight.w400)),
              SizedBox(
                width: 5.sp,
              ),
              InkWell(
                onTap: () => loadData(),
                child: Text("Tap to retry",
                    style: TextStyle(
                        fontSize: 14,
                        color: colorBlack,
                        fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}