import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:shop_app/src/core/widgets/app_text.dart';
import 'package:shop_app/src/themes/app_colors.dart';
import '../../../core/dialogs/dialog_loading.dart';
import '../controllers/product_add_controller.dart';
import '../../../utils/sizer_custom/sizer.dart';

import '../../../public/components.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/custom_button.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class ProductAddView extends GetView<ProductAddController> {
  const ProductAddView({Key? key}) : super(key: key);

  void addProduct(ProductAddController addProductController) {
    String productName = controller.productNameController.text.trim();
    String description = controller.descriptionController.text.trim();
    String price = controller.priceController.text.trim();
    String discount = controller.discountController.text.trim();
    String quantity = controller.quantityController.text.trim();
    String time = controller.timeController.text.trim();
    List<File> imageFile = controller.imageFileSelected;
    String category = controller.category;

    if (imageFile.isEmpty) {
      Components.showSnackBar(
        'Type in product image',
        title: 'Image',
      );
    } else if (productName.isEmpty) {
      Components.showSnackBar(
        'Type in product name',
        title: 'Name',
      );
    } else if (description.isEmpty) {
      Components.showSnackBar(
        'Type in product description',
        title: 'Description',
      );
    } else if (price.isEmpty) {
      Components.showSnackBar(
        'Type in product price',
        title: 'Price',
      );
    } else if (quantity.isEmpty) {
      Components.showSnackBar(
        'Type in product quantity',
        title: 'Quantity',
      );
    } else {
      addProductController.addProduct(
        name: productName,
        description: description,
        price: int.parse(price),
        discount: int.parse(discount),
        quantity: int.parse(quantity),
        category: category,
        images: imageFile,
        time: time,
      );
      // _productNameController.text = '';
      // _descriptionController.text = '';
      // _priceController.text = '';
      // _discountController.text = '';
      // _quantityController.text = '';
      // _timeController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final _addProductFormKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: Components.customAppBar(
        context,
        "Add Product",
      ),
      body: GetBuilder<ProductAddController>(builder: (addProductController) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _addProductFormKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.sp),
                  controller.imageFileSelected.isNotEmpty
                      ? SizedBox(
                          height: 200,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: controller.imageFileSelected.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return Row(
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.sp),
                                        child: Image.file(
                                          controller.imageFileSelected[index],
                                          fit: BoxFit.fill,
                                          height: 200.sp,
                                          width: SizerUtil.width - 20.sp,
                                        ),
                                      ),
                                      GetBuilder<ProductAddController>(
                                          builder: (productAddController) {
                                        return Positioned(
                                          top: 10.sp,
                                          right: 10.sp,
                                          child: InkWell(
                                            onTap: () {
                                              productAddController
                                                  .removePhoto(index);
                                            },
                                            child: const CircleAvatar(
                                              backgroundColor: Colors.black38,
                                              child: Icon(
                                                Icons.close_rounded,
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                    ],
                                  ),
                                  SizedBox(width: 5.sp),
                                ],
                              );
                            },
                          ),
                        )
                      : GestureDetector(
                          onTap: () => controller.selectImage(),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(10.sp),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            child: Container(
                              width: double.infinity,
                              height: 150.sp,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.folder_open,
                                    size: 40.sp,
                                  ),
                                  SizedBox(height: 15.sp),
                                  Text(
                                    'Select Product Images',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  SizedBox(height: 20.sp),
                  AppText('Product Name'),
                  SizedBox(height: 10.sp),
                  AppTextField(
                    textController: controller.productNameController,
                    hintText: 'Product Name',
                    icon: Icons.person,
                  ),
                  SizedBox(height: 20.sp),
                  AppText('Product Description'),
                  SizedBox(
                    height: 10.sp,
                  ),
                  AppTextField(
                    textController: controller.descriptionController,
                    hintText: 'Product Description',
                    icon: Icons.description,
                    maxLines: 3,
                  ),
                  SizedBox(height: 20.sp),
                  AppText('Product Price'),
                  SizedBox(height: 10.sp),
                  AppTextField(
                    keyboardType: TextInputType.number,
                    textController: controller.priceController,
                    hintText: 'Product Price',
                    icon: Icons.money,
                  ),
                  SizedBox(height: 20.sp),
                  AppText('Product Discount'),
                  SizedBox(height: 10.sp),
                  AppTextField(
                    keyboardType: TextInputType.number,
                    textController: controller.discountController,
                    hintText: 'Product Discount',
                    icon: Icons.money,
                  ),
                  SizedBox(height: 20.sp),
                  AppText('Product Quantity'),
                  SizedBox(
                    height: 10.sp,
                  ),
                  AppTextField(
                    keyboardType: TextInputType.number,
                    textController: controller.quantityController,
                    hintText: 'Product Quantity',
                    icon: Icons.production_quantity_limits,
                  ),
                  SizedBox(height: 20.sp),
                  AppText('Product Time'),
                  SizedBox(
                    height: 10.sp,
                  ),
                  AppTextField(
                    keyboardType: TextInputType.number,
                    textController: controller.timeController,
                    hintText: 'Product Time',
                    icon: Icons.access_time_rounded,
                  ),
                  SizedBox(height: 10.sp),
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<ProductAddController>(
                      builder: (productAddController) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(productAddController.category),
                            DropdownButton(
                              borderRadius: BorderRadius.circular(
                                10.sp,
                              ),
                              dropdownColor: colorPrimary,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey,
                              ),
                              iconSize: 24.sp,
                              elevation: 4,
                              underline: Container(
                                height: 0,
                              ),
                              // style: subTitleStyle,
                              items: controller.productCategories
                                  .map((String item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: AppText(item),
                                );
                              }).toList(),
                              onChanged: (String? newVal) {
                                productAddController.changeCategory(newVal);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  CustomButton(
                    buttomText: 'Add Meal',
                    onPressed: () {
                      showDialogLoading(context);
                      addProduct(addProductController);
                    },
                  ),
                  SizedBox(height: 10.sp),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
