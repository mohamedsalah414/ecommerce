import 'package:ecommercebusiness/src/core/utils/helper_extenstions.dart';
import 'package:ecommercebusiness/src/core/widgets/text_widget.dart';
import 'package:ecommercebusiness/src/presentation/cart/viewmodel/cart_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(builder: (context, ref, child) {
        final cartItems = ref.watch(cart);
        return Padding(
          padding: EdgeInsets.all(15),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: cartItems.productItems.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  contentPadding: EdgeInsets.all(8),
                  leading: Container(
                    padding: EdgeInsets.all(10),
                    child: Image.network(
                      cartItems.productItems[index].product.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  title: TextWidget(
                      txt: cartItems.productItems[index].product.title),
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
                                productId:
                                    cartItems.productItems[index].productId);
                          },
                          icon: Icon(Icons.delete))
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
