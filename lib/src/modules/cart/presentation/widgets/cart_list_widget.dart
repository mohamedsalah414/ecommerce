import 'package:ecommercebusiness/src/core/utils/helper_extenstions.dart';
import 'package:ecommercebusiness/src/core/widgets/text_widget.dart';
import 'package:ecommercebusiness/src/modules/cart/presentation/viewmodel/cart_riverpod.dart';
import 'package:flutter/material.dart';

class CartListWidget extends StatelessWidget {
  const CartListWidget({
    super.key,
    required this.cartItems,
  });

  final CartRiverPod cartItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: cartItems.productItems.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(8),
              leading: Container(
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  cartItems.productItems[index].product.image,
                  fit: BoxFit.contain,
                ),
              ),
              title:
                  TextWidget(txt: cartItems.productItems[index].product.title),
              subtitle: TextWidget(
                  txt: cartItems.productItems[index].product.category
                      .capitalize()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextWidget(
                    txt: '\$${cartItems.productItems[index].product.price}',
                    fontWeight: FontWeight.bold,
                  ),
                  IconButton(
                      onPressed: () {
                        cartItems.removeProduct(
                            productId: cartItems.productItems[index].productId);
                      },
                      icon: const Icon(Icons.delete))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
