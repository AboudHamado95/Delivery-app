import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/data/repository/popular_product_repo.dart';
import 'package:delivery/models/product_model.dart';
import 'package:delivery/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;

  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity {
    return _quantity;
  }

  int _inCartItem = 0;
  int get inCartItem {
    return _inCartItem + _quantity;
  }

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      if (kDebugMode) {
        print('increment$_quantity');
      }
    } else {
      _quantity = checkQuantity(_quantity - 1);
      if (kDebugMode) {
        print('decrement$_quantity');
      }
    }
    update();
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItem = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    if (kDebugMode) {
      print('exist or not:  $exist');
    }
    if (exist) {
      _inCartItem = _cart.getQuantity(product);
    }
    if (kDebugMode) {
      print('the quantity in the cart is  $_inCartItem');
    }
  }

  int checkQuantity(int quantity) {
    if ((_inCartItem + quantity) < 0) {
      Get.snackbar('Item count:', 'You can\'t reduce more ! ',
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      if (_inCartItem > 0) {
        _quantity = -_inCartItem;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItem + quantity) > 20) {
      Get.snackbar('Item count:', 'You can\'t add more ! ',
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      if (_inCartItem > 0) {
        _inCartItem = 0;
        return quantity;
      }
      return 20;
    } else {
      return quantity;
    }
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItem = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      if (kDebugMode) {
        print('The id is ${value.id} The quantity is ${value.quantity}');
      }
    });
    update();
  }

  int totalItems(ProductModel product) {
    return _cart.totalItems(product);
  }

 
}
