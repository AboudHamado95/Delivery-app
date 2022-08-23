import 'package:delivery/home_page.dart';
import 'package:delivery/pages/cart/cart_page.dart';
import 'package:delivery/pages/food/popular_food_detail.dart';
import 'package:delivery/pages/food/recommended_food_detail.dart';
import 'package:delivery/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initialRoute = '/';
  static const String popularFood = '/popular_food';
  static const String recommendedFood = '/recommended_food';
  static const String cartPage = '/cart_page';
  static const String splashPage = '/splash_page';

  static String getSplashPage() => splashPage;
  static String getInitial() => initialRoute;
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => cartPage;

  static List<GetPage> routes = [
    GetPage(
        name: splashPage,
        page: () {
          return const SplashScreen();
        },
        transition: Transition.fade),
    GetPage(
        name: initialRoute,
        page: () {
          return const HomePage();
        },
        transition: Transition.fade),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = int.parse(Get.parameters['pageId']!);
          var page = Get.parameters['page']!;

          return PopularFoodDetail(
            pageId: pageId,
            page: page,
          );
        },
        transition: Transition.fade),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = int.parse(Get.parameters['pageId']!);
          var page = Get.parameters['page']!;
          return RecommendedFoodDetail(
            pageId: pageId,
            page: page,
          );
        },
        transition: Transition.fade),
    GetPage(
        name: cartPage,
        page: () {
          return const CartPage();
        },
        transition: Transition.fade),
  ];
}
