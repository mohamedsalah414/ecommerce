import 'package:ecommercebusiness/src/core/utils/helper_extenstions.dart';
import 'package:ecommercebusiness/src/core/widgets/text_widget.dart';
import 'package:ecommercebusiness/src/data/model/product/product_model.dart';
import 'package:ecommercebusiness/src/presentation/home/screens/home_screen.dart';
import 'package:ecommercebusiness/src/presentation/product_details/screens/product_modify_screen.dart';
import 'package:ecommercebusiness/src/presentation/product_details/viewmodel/product_riverpod.dart';
import 'package:ecommercebusiness/src/presentation/product_details/widgets/product_details_widget.dart';
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
            return ProductDetailsWidget(
                quantityForItem: quantityForItem, data: data, id: widget.id);
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
