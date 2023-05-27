import 'package:ecommercebusiness/src/data/model/cart/cart_model.dart';
import 'package:ecommercebusiness/src/data/model/product/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cart = ChangeNotifierProvider((ref) => CartRiverPod());

class CartRiverPod extends ChangeNotifier {
  List<OrderModel> cartItems = [];
  List<OrderProductModel> productItems = [];
  addItem({
    required int id,
    required int userId,
    required DateTime date,
  }) async {
    OrderModel singleCartItem =
        OrderModel(id: id, userId: userId, date: date, products: productItems);
    cartItems.add(singleCartItem);
    notifyListeners();
  }

  int quantityForProducts = 0;
  addProduct({required int quantity, required ProductModel product}) {
    OrderProductModel singleProductItems = OrderProductModel(
        productId: quantityForProducts, quantity: quantity, product: product);
    productItems.add(singleProductItems);
    notifyListeners();
  }

  int increaseQuantity() {
    notifyListeners();
    return quantityForProducts++;
  }

  removeProduct({required int productId}) {
    quantityForProducts--;
    productItems.removeWhere((element) => element.productId == productId);
    notifyListeners();
  }

  List<OrderModel> getAllItems() {
    return cartItems;
  }
}
