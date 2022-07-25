import 'package:get/get.dart';

import 'package:delivery/data/repository/cart_repo.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
}
