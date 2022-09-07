import 'package:delivery/base/show_custom_snackbar.dart';
import 'package:delivery/controllers/auth_controller.dart';
import 'package:delivery/models/sign_up_body_model.dart';
import 'package:delivery/pages/auth/sign_in_page.dart';
import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/utils/icons.dart';
import 'package:delivery/widgets/app_text_field.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttericon/typicons_icons.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    List<IconData> iconDataList = [
      Typicons.twitter,
      Typicons.facebook,
      SocialMedia.google,
    ];

    void _registration() {
      var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar('Type in your name', title: 'Name');
      } else if (phone.isEmpty) {
        showCustomSnackBar('Type in your phone number', title: 'Phone number');
      } else if (email.isEmpty) {
        showCustomSnackBar('Type in your email address',
            title: 'Email address');
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar('Type in valid email address',
            title: 'Valid email address');
      } else if (password.isEmpty) {
        showCustomSnackBar('Type in your password', title: 'Password');
      } else if (password.length < 6) {
        showCustomSnackBar('Password can not be less than six characters',
            title: 'Password');
      } else {
        showCustomSnackBar('All went well', title: 'Perfect', isError: false);
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            if (kDebugMode) {
              print(status.message);
            }
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.screenWidth * 0.05,
            ),
            SizedBox(
              height: Dimensions.screenHeight * 0.2,
              child: Center(
                child: Container(
                  color: Colors.white,
                  child: CircleAvatar(
                    backgroundImage:
                        const AssetImage('assets/images/delivery.png'),
                    radius: Dimensions.radius20 * 3,
                  ),
                ),
              ),
            ),
            AppTextFormField(
                controller: nameController,
                hintText: 'Name',
                icon: Icons.person),
            SizedBox(
              height: Dimensions.screenWidth * 0.05,
            ),
            AppTextFormField(
                controller: phoneController,
                hintText: 'Phone',
                icon: Icons.phone),
            SizedBox(
              height: Dimensions.screenWidth * 0.05,
            ),
            AppTextFormField(
                controller: passwordController,
                hintText: 'Password',
                icon: Icons.email),
            SizedBox(
              height: Dimensions.screenWidth * 0.05,
            ),
            AppTextFormField(
                controller: emailController,
                hintText: 'Email',
                icon: Icons.email),
            SizedBox(
              height: Dimensions.screenWidth * 0.05,
            ),
            GestureDetector(
              onTap: () => _registration(),
              child: Container(
                width: Dimensions.screenWidth / 2,
                height: Dimensions.screenHeight / 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor),
                child: Center(
                  child: BigText(
                    text: 'Sign up',
                    size: Dimensions.font16 + Dimensions.font20 / 2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height20),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Get.to(() => const SignInPage(),
                      transition: Transition.fade),
                text: 'Have an account already?',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font20,
                ),
              ),
            ),
            SizedBox(height: Dimensions.height20),
            RichText(
              text: TextSpan(
                text: 'Sign up using one of the following methods',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font16,
                ),
              ),
            ),
            SizedBox(height: Dimensions.height20),
            Wrap(
              children: List.generate(
                3,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width15),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundColor: Colors.grey.withOpacity(0.1),
                    child: Icon(iconDataList[index]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
