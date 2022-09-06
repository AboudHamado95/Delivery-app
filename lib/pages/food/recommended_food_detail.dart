import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:get/get.dart';

import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/controllers/popular_product_controller.dart';
import 'package:delivery/controllers/recommended_product_controller.dart';
import 'package:delivery/routes/route_helper.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/app_icon.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:delivery/widgets/expandable_text_widget.dart';

class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail(
      {Key? key, required this.pageId, required this.page})
      : super(key: key);
  final int pageId;
  final String page;

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Padding(
                padding: EdgeInsets.only(
                    bottom: Dimensions.height10,
                    right: Dimensions.width10,
                    left: Dimensions.width10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getInitial());
                        },
                        child: const AppIcon(icon: Icons.clear)),
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.cartPage);
                        },
                        child:
                            const AppIcon(icon: Icons.shopping_cart_outlined))
                  ],
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(Dimensions.height20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius30),
                      topRight: Radius.circular(Dimensions.radius30),
                    ),
                  ),
                  padding: EdgeInsets.only(
                      top: Dimensions.height10 / 2,
                      bottom: Dimensions.height10),
                  child: Center(
                    child:
                        BigText(text: product.name!, size: Dimensions.font26),
                  ),
                ),
              ),
              pinned: true,
              backgroundColor: AppColors.yellowColor,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstants.BASE_URL +
                      AppConstants.UPLOAD_URL +
                      product.img!,
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.height10,
                        horizontal: Dimensions.width10),
                    margin: EdgeInsets.symmetric(
                        vertical: Dimensions.height20,
                        horizontal: Dimensions.width10),
                    child: ExpandableTextWidget(
                      text: product.description!,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width20 * 1.6,
                      vertical: Dimensions.height10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius20),
                          topRight: Radius.circular(Dimensions.radius20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(false);
                        },
                        child: AppIcon(
                            iconSize: Dimensions.iconsSize24,
                            icon: Icons.remove,
                            iconColor: Colors.white,
                            backgroundColor: AppColors.mainColor),
                      ),
                      BigText(
                        text: '\$${product.price!} X ${controller.inCartItem}',
                        color: AppColors.mainBlackColor,
                        size: Dimensions.font20,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(true);
                        },
                        child: AppIcon(
                            iconSize: Dimensions.iconsSize24,
                            icon: Icons.add,
                            iconColor: Colors.white,
                            backgroundColor: AppColors.mainColor),
                      )
                    ],
                  ),
                ),
                Container(
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
                          child: const Icon(
                            Icons.favorite,
                            color: AppColors.mainColor,
                          )),
                      GestureDetector(
                        onTap: () {
                          controller.addItem(product);
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
                ),
              ],
            );
          },
        ));
  }
}
