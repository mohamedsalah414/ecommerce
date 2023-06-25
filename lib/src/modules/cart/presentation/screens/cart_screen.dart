import 'package:ecommercebusiness/src/core/widgets/text_widget.dart';
import 'package:ecommercebusiness/src/modules/cart/presentation/viewmodel/cart_riverpod.dart';
import 'package:ecommercebusiness/src/modules/cart/presentation/widgets/empty_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/cart_list_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(
          txt: 'My Cart',
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Consumer(builder: (context, ref, child) {
        final cartItems = ref.watch(cart);
        return cartItems.productItems.isNotEmpty
            ? CartListWidget(cartItems: cartItems)
            : const EmptyCartWidget();
      }),
    );
  }
}
