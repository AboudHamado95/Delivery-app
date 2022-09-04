import 'dart:convert';

import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/models/cart_model.dart';
import 'package:delivery/routes/route_helper.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/app_icon.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:delivery/widgets/small_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatefulWidget {
  const CartHistory({super.key});

  @override
  State<CartHistory> createState() => _CartHistoryState();
}

class _CartHistoryState extends State<CartHistory> {
  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = {};

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemPerOrderToList();

    var listCounter = 0;

    // for (int i = 0; i < cartItemsPerOrder.length; i++) {
    //   for (int j = 0; j < itemsPerOrder[i]; j++) {
    //     if (kDebugMode) {
    //       print('inner loop j index$j');
    //       print('my loop is${getCartHistoryList[counterList++]}');
    //     }
    //   }
    // }

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: Dimensions.height10 * 10,
              width: double.maxFinite,
              padding: EdgeInsets.only(
                top: Dimensions.height45,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: Dimensions.height10,
              ),
              decoration: BoxDecoration(
                  color: AppColor.mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimensions.radius20),
                    bottomRight: Radius.circular(Dimensions.radius20),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BigText(
                    text: 'Cart History',
                    color: Colors.white,
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: Colors.white,
                    iconSize: Dimensions.iconsSize24,
                    backgroundColor: AppColor.mainColor,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  top: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      for (int i = 0; i < itemsPerOrder.length; i++)
                        Container(
                          height: Dimensions.popularFoodImgSize / 2.65,
                          margin: EdgeInsets.only(
                            bottom: Dimensions.height20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (() {
                                DateTime parseDate =
                                    DateFormat('yyyy-MM-dd HH:mm:ss').parse(
                                        getCartHistoryList[listCounter].time!);
                                var inputData =
                                    DateTime.parse(parseDate.toString());
                                var outputFormat =
                                    DateFormat('MM/dd/yyyy hh:mm a');
                                var outputData = outputFormat.format(inputData);
                                return Container(
                                  margin:
                                      EdgeInsets.only(left: Dimensions.width10),
                                  child: BigText(text: outputData.toString()),
                                );
                              }()),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(
                                      itemsPerOrder[i],
                                      (index) {
                                        if (listCounter <
                                            getCartHistoryList.length) {
                                          listCounter++;
                                        }
                                        return index <= 2
                                            ? Container(
                                                height: Dimensions.height20 * 4,
                                                width: Dimensions.height20 * 4,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Dimensions.width10 / 2,
                                                    vertical:
                                                        Dimensions.height10 /
                                                            2),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius15 /
                                                              2),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        AppConstants.BASE_URL +
                                                            AppConstants
                                                                .UPLOAD_URL +
                                                            getCartHistoryList[
                                                                    listCounter -
                                                                        1]
                                                                .img!),
                                                  ),
                                                ),
                                              )
                                            : Container();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.popularFoodImgSize / 4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const SmallText(text: 'Total'),
                                        BigText(
                                          text: '${itemsPerOrder[i]} Items',
                                          color: AppColor.titleColor,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            var orderTime =
                                                cartOrderTimeToList();
                                            Map<int, CartModel> moreOrder = {};

                                            for (int j = 0;
                                                j < getCartHistoryList.length;
                                                j++) {
                                              if (getCartHistoryList[j].time ==
                                                  orderTime[i]) {
                                                moreOrder.putIfAbsent(
                                                  getCartHistoryList[j].id!,
                                                  () => CartModel.fromJson(
                                                    jsonDecode(
                                                      jsonEncode(
                                                          getCartHistoryList[
                                                              j]),
                                                    ),
                                                  ),
                                                );
                                                if (kDebugMode) {
                                                  print(
                                                      'The Cart or product id is ${getCartHistoryList[j].id}');
                                                  print(
                                                      'Product info is ${jsonEncode(getCartHistoryList[j])}');
                                                }
                                              }
                                            }
                                            Get.find<CartController>()
                                                .setItems = moreOrder;
                                            Get.find<CartController>().addToCartList();
                                            Get.toNamed(RouteHelper.getCartPage());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.width10,
                                                vertical:
                                                    Dimensions.height10 / 2),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15 / 3),
                                              border: Border.all(
                                                  width: 1,
                                                  color: AppColor.mainColor),
                                            ),
                                            child: const SmallText(
                                              text: 'one more',
                                              color: AppColor.mainColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
