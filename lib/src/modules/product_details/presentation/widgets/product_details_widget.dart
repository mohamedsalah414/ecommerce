import 'package:ecommercebusiness/src/core/utils/app_colors.dart';
import 'package:ecommercebusiness/src/core/utils/helper_extenstions.dart';
import 'package:ecommercebusiness/src/core/widgets/text_widget.dart';
import 'package:ecommercebusiness/src/modules/cart/presentation/viewmodel/cart_riverpod.dart';
import 'package:ecommercebusiness/src/modules/home/data/model/product/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({
    super.key,
    required this.quantityForItem,
    required this.id,
    required this.data,
  });

  final int quantityForItem;
  final String id;
  final ProductModel data;

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
                    label:
                        TextWidget(txt: '${cartAddition.quantityForProducts}'),
                    child: ElevatedButton.icon(
                        onPressed: () {
                          cartAddition.increaseQuantity();
                          cartAddition.addProduct(
                              quantity: quantityForItem, product: data);
                          cartAddition.addItem(
                              id: int.parse(id),
                              userId: 1,
                              date: DateTime.now());
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
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
  }
}
