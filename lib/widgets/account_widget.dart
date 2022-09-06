import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/app_icon.dart';
import 'package:flutter/material.dart';

import 'package:delivery/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({Key? key, required this.appIcon, required this.bigText})
      : super(key: key);
  final AppIcon appIcon;
  final BigText bigText;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
          left: Dimensions.width20,
          top: Dimensions.height10,
          bottom: Dimensions.height10),
      child: Row(
        children: [appIcon, SizedBox(width: Dimensions.width20), bigText],
      ),
    );
  }
}
