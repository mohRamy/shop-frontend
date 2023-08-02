import 'package:shop_app/src/modules/search/controllers/search_controller.dart';
import 'package:shop_app/src/modules/search/widgets/search_widget.dart';
import 'package:shop_app/src/themes/app_colors.dart';
import 'package:shop_app/src/utils/sizer_custom/sizer.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/app_icon.dart';


class SearchView extends GetView<SearchControlle> {
  const SearchView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.products = [];
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: colorPrimary,
            width: double.maxFinite,
            height: 100.sp,
            padding: EdgeInsets.only(
              top: Dimensions.height45,
              left: Dimensions.width20,
            ),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(onTap: () => Get.back(), icon: Icons.arrow_back_ios, ),
                SizedBox(width: Dimensions.width15),
                GetBuilder<SearchControlle>(builder: (searchCtrl) {
                  return Container(
                    width: 330,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: const Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: TextField(
                      autofocus: true,
                      onChanged: (val) {
                        searchCtrl.changeSearchStatus(val);
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(Dimensions.height10),
                        hintText: "Search Products ...",
                        prefixIcon: Icon(
                          Icons.search,
                          color: colorMedium,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          GetBuilder<SearchControlle>(
            builder: (controller) => controller.products.isEmpty
                ? Container()
                : MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: Expanded(
                      child: ListView(
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.products.length,
                            itemBuilder: (context, index) {
                              return SearchWidget(
                                  product: controller.products[index],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
