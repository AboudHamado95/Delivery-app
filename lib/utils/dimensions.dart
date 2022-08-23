import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  //
  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 6.03;

  //Dynamic height padding and margin
  static double height10 = screenHeight / 84.4;
  static double height15 = screenHeight / 56.27;
  static double height20 = screenHeight / 42.2;
  static double height30 = screenHeight / 28.13;
  static double height45 = screenHeight / 18.76;

  //Dynamic width padding and margin
  static double width10 = screenHeight / 84.4;
  static double width15 = screenHeight / 56.27;
  static double width20 = screenHeight / 42.2;
  static double width30 = screenHeight / 28.13;

  //Font size
  static double font16 = screenHeight / 52.75;
  static double font20 = screenHeight / 42.2;
  static double font26 = screenHeight / 32.46;

  //Radius
  static double radius15 = screenHeight / 56.24;
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.3;

  //Icon size
  static double iconsSize16 = screenHeight / 52.57;
  static double iconsSize20 = screenHeight / 42.57;
  static double iconsSize24 = screenHeight / 35.17;

  //List view size
  static double listViewImgSize = screenWidth / 3.25;
  static double listViewTextContSize = screenWidth / 3.9;

  //Popular food
  static double popularFoodImgSize = screenHeight / 2.41;

  //Bottom height
  static double bottomHeightBar = screenHeight / 7.03;

  //Splash screen dimensions
  static double splashImg = screenHeight / 3.38;
}
