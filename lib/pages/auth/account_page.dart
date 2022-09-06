import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/account_widget.dart';
import 'package:delivery/widgets/app_icon.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: 'Profile',
          size: Dimensions.font16 + 8,
          color: Colors.white,
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: Dimensions.height20),
        width: double.maxFinite,
        child: Column(
          children: [
            AppIcon(
              icon: Icons.person,
              backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              iconSize: Dimensions.height30 + Dimensions.height45,
              size: Dimensions.height30 * 5,
            ),
            SizedBox(height: Dimensions.height30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.person,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10 * 5 / 2,
                        size: Dimensions.height10 * 5,
                      ),
                      bigText: BigText(text: 'Ahmed'),
                    ),
                    SizedBox(height: Dimensions.height20),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.phone,
                        backgroundColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10 * 5 / 2,
                        size: Dimensions.height10 * 5,
                      ),
                      bigText: BigText(text: '00963956269626'),
                    ),
                    SizedBox(height: Dimensions.height20),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.email,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10 * 5 / 2,
                        size: Dimensions.height10 * 5,
                      ),
                      bigText: BigText(text: 'info@gmail.com'),
                    ),
                    SizedBox(height: Dimensions.height20),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.location_on,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10 * 5 / 2,
                        size: Dimensions.height10 * 5,
                      ),
                      bigText: BigText(text: 'Fill in your address'),
                    ),
                    SizedBox(height: Dimensions.height20),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.message_outlined,
                        backgroundColor: Colors.redAccent,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10 * 5 / 2,
                        size: Dimensions.height10 * 5,
                      ),
                      bigText: BigText(text: 'Ahmed'),
                    ),
                    SizedBox(height: Dimensions.height20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
