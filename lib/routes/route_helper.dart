import 'package:delivery/pages/food/popular_food_detail.dart';
import 'package:delivery/pages/food/recommended_food_detail.dart';
import 'package:delivery/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initialRoute = '/';
  static const String popularFood = '/popular_food';
  static const String recommendedFood = '/recommended_food';

  static String getInitial() => initialRoute;
  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';
  static String getRecommendedFood(int pageId) =>
      '$recommendedFood?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(
        name: initialRoute,
        page: () {
          return const MainFoodPage();
        },
        transition: Transition.fade),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = int.parse(Get.parameters['pageId']!);
          return PopularFoodDetail(
            pageId: pageId,
          );
        },
        transition: Transition.fade),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = int.parse(Get.parameters['pageId']!);
          return RecommendedFoodDetail(
            pageId: pageId,
          );
        },
        transition: Transition.fade),
  ];
}
