import 'package:ecommercebusiness/src/core/utils/helper_extenstions.dart';
import 'package:ecommercebusiness/src/core/widgets/text_widget.dart';
import 'package:ecommercebusiness/src/data/model/product_model.dart';
import 'package:ecommercebusiness/src/presentation/cart/viewmodel/cart_riverpod.dart';
import 'package:ecommercebusiness/src/presentation/home/screens/home_screen.dart';
import 'package:ecommercebusiness/src/presentation/product_details/screens/product_modify_screen.dart';
import 'package:ecommercebusiness/src/presentation/product_details/viewmodel/product_riverpod.dart';
import 'package:ecommercebusiness/src/presentation/product_details/widgets/remove_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/app_colors.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String id;

  const ProductDetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductModel? dataCallback;
  int quantityForItem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                  builder: (context) => ProductModifyScreen(
                    id: widget.id,
                    type: 'update',
                  ),
                ))
                    .then((value) {
                  setState(() {
                    dataCallback = value;
                  });
                });
              },
              style:
                  IconButton.styleFrom(backgroundColor: AppColor.carolinaBlue),
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return RemoveDialogWidget(widget.id);
                  },
                ).then((value) {
                  context.pushAndRemoveUntil(HomeScreen());
                });
              },
              style: IconButton.styleFrom(backgroundColor: AppColor.orange),
              icon: const Icon(Icons.delete)),
        ],
      ),
      body: Consumer(builder: (context, ref, child) {
        final productDetails =
            ref.watch(productDetailsScreenProducts(widget.id));
        return productDetails.when(
          data: (data) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      height: context.height * .5,
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.all(10),
                      child: Image.network(
                        data.image,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        },
                      )),
                  15.ph,
                  TextWidget(
                    txt: data.title,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  15.ph,
                  const TextWidget(
                    txt: 'About',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  5.ph,
                  TextWidget(
                    txt: data.description,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                  15.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppColor.yellow,
                            size: 25,
                          ),
                          TextWidget(
                            txt: '${data.rating!.rate} Ratings',
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.center,
                            fontSize: 16,
                            color: AppColor.grey,
                          ),
                        ],
                      ),
                      TextWidget(
                        txt: '${data.rating!.count} Reviews',
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                        fontSize: 16,
                        color: AppColor.grey,
                      ),
                    ],
                  ),
                  10.ph,
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                        color: AppColor.carolinaBlue,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextWidget(
                          txt: ' \$${data.price}',
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: AppColor.primaryBLue,
                        ),
                        Consumer(builder: (context, ref, child) {
                          final cartAddition = ref.watch(cart);
                          return Badge(
                            label: TextWidget(
                                txt: '${cartAddition.quantityForProducts}'),
                            child: ElevatedButton.icon(
                                onPressed: () {
                                  cartAddition.increaseQuantity();
                                  cartAddition.addProduct(
                                      quantity: quantityForItem, product: data);
                                  cartAddition.addItem(
                                      id: int.parse(widget.id),
                                      userId: 1,
                                      date: DateTime.now());
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                icon: const Icon(
                                  Icons.shopping_cart,
                                  color: AppColor.white,
                                ),
                                label: const TextWidget(
                                  txt: 'Add to cart',
                                  color: AppColor.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                          );
                        })
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          error: (error, stackTrace) {
            debugPrint(error.toString());
            return const Center(
              child: TextWidget(txt: 'Error'),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      }),
    );
  }
}
