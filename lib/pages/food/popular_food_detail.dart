import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/controllers/popular_product_controller.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:delivery/routes/route_helper.dart';
import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/app_column.dart';
import 'package:delivery/widgets/app_icon.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:delivery/widgets/expandable_text_widget.dart';

class PopularFoodDetail extends StatefulWidget {
  const PopularFoodDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);
  final int pageId;
  final String page;

  @override
  State<PopularFoodDetail> createState() => _PopularFoodDetailState();
}

class _PopularFoodDetailState extends State<PopularFoodDetail> {
  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[widget.pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    if (kDebugMode) {
      print('page is id ${widget.pageId}');
    }
    if (kDebugMode) {
      print('page is ${product.name}');
    }
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            //background image
            Positioned(
              left: 0.0,
              right: 0.0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        product.img!),
                  ),
                ),
              ),
            ),
            //icon widget
            Positioned(
              top: Dimensions.height30,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (widget.page == 'cartpage') {
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: const AppIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<PopularProductController>(
                    builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          if (controller.totalItems(product) >= 1) {
                            Get.toNamed(RouteHelper.cartPage);
                          }
                        },
                        child: Stack(
                          children: [
                            const AppIcon(icon: Icons.shopping_cart_outlined),
                            Get.find<PopularProductController>()
                                        .totalItems(product) >=
                                    1
                                ? Positioned(
                                    top: 0.0,
                                    right: 0.0,
                                    child: AppIcon(
                                      icon: Icons.circle,
                                      size: Dimensions.iconsSize20,
                                      iconColor: Colors.transparent,
                                      backgroundColor: AppColors.mainColor,
                                    ),
                                  )
                                : Container(),
                            Get.find<PopularProductController>()
                                        .totalItems(product) >=
                                    1
                                ? Positioned(
                                    top: 0.0,
                                    right: Dimensions.width10 - 5,
                                    child: BigText(
                                      text: controller.inCartItem.toString(),
                                      color: Colors.white,
                                      size: Dimensions.font16,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            //introduction of food
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              top: Dimensions.popularFoodImgSize - 40,
              child: Container(
                padding: EdgeInsets.only(
                  right: Dimensions.width20,
                  left: Dimensions.width20,
                  top: Dimensions.height20,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius30),
                      topLeft: Radius.circular(Dimensions.radius30),
                    ),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(height: Dimensions.height20),
                    Padding(
                      padding: EdgeInsets.only(bottom: Dimensions.height10),
                      child: BigText(text: 'Introduce'),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: ExpandableTextWidget(text: product.description!),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularProduct) {
            return Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  bottom: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
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
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(false);
                          },
                          child: const Icon(
                            Icons.remove,
                            color: AppColors.signColor,
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                        BigText(text: popularProduct.inCartItem.toString()),
                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(true);
                          },
                          child: const Icon(
                            Icons.add,
                            color: AppColors.signColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      popularProduct.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                      ),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor),
                      child: BigText(
                        text: '\$ ${product.price!} | Add to cart',
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
