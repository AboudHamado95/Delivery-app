import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoDataPage(
      {super.key, required this.text, this.imgPath = 'assets/images/cart/mdpi.png'});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imgPath,
            height: Get.height * 0.22,
            width: Get.width * 0.5,
          ),
          SizedBox(height: Get.height * 0.03),
          Text(
            text,
            style: TextStyle(
                fontSize: Get.height * 0.0175,
                color: Theme.of(context).disabledColor),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
