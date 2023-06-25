import 'package:ecommercebusiness/src/core/utils/app_colors.dart';
import 'package:ecommercebusiness/src/core/utils/helper_extenstions.dart';
import 'package:ecommercebusiness/src/core/widgets/text_widget.dart';
import 'package:ecommercebusiness/src/modules/home/data/model/product/product_model.dart';
import 'package:ecommercebusiness/src/modules/product_details/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class ProductsGridWidget extends StatelessWidget {
  final List<ProductModel> data;
  const ProductsGridWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        mainAxisSpacing: 25,
        crossAxisSpacing: 10,
      ),
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.push(ProductDetailsScreen(id: data[index].id.toString()));
          },
          child: GridTile(
            footer: Container(
              decoration: const BoxDecoration(
                color: AppColor.backgroundBLue,
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    txt: data[index].category.capitalize(),
                    fontWeight: FontWeight.normal,
                    color: AppColor.grey,
                    textAlign: TextAlign.start,
                    fontSize: 14,
                    maxLines: 2,
                  ),
                  5.ph,
                  TextWidget(
                    txt: data[index].title,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 15,
                    maxLines: 2,
                  ),
                  10.ph,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppColor.yellow,
                            size: 20,
                          ),
                          TextWidget(
                            txt:
                                '${data[index].rating!.rate} | ${data[index].rating!.count}',
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.center,
                            fontSize: 14,
                            color: AppColor.grey,
                          ),
                        ],
                      ),
                      TextWidget(
                        txt: ' \$${data[index].price}',
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.end,
                        fontSize: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            child: Container(
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Image.network(
                  data[index].image,
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
          ),
        );
      },
    );
  }
}
