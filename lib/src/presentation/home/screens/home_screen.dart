import 'package:ecommercebusiness/src/core/utils/app_colors.dart';
import 'package:ecommercebusiness/src/core/utils/helper_extenstions.dart';
import 'package:ecommercebusiness/src/core/widgets/text_widget.dart';
import 'package:ecommercebusiness/src/presentation/cart/screens/cart_screen.dart';
import 'package:ecommercebusiness/src/presentation/home/viewmodel/category_riverpod.dart';
import 'package:ecommercebusiness/src/presentation/home/viewmodel/products_riverpod.dart';
import 'package:ecommercebusiness/src/presentation/product_details/screens/product_details_screen.dart';
import 'package:ecommercebusiness/src/presentation/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedChip = 'all';
  String sorted = 'asc';
  String limit = '20';

  @override
  Widget build(BuildContext context) {
    Map<String, String> fetchedData = {
      'category': selectedChip,
      'sort': sorted,
      'limit': limit
    };
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(txt: 'Ecommerce'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
                child: IconButton(
                    onPressed: () {
                      context.push(CartScreen());
                    },
                    icon: Icon(Icons.shopping_cart))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
                child: IconButton(
                    onPressed: () {
                      context.push(ProfileScreen());
                    },
                    icon: Icon(Icons.person))),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const TextWidget(
            txt: 'Categories',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          10.ph,
          Consumer(builder: (context, ref, child) {
            final cat = ref.watch(categories);
            return cat.when(
              data: (data) {
                return Wrap(
                  runSpacing: 5,
                  spacing: 7,
                  children: [
                    for (int i = 0; i < data.length; i++)
                      ChoiceChip(
                        label: TextWidget(
                          txt: data[i].capitalize(),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        selected: selectedChip == data[i],
                        onSelected: (value) {
                          setState(() {
                            selectedChip =
                                selectedChip == data[i] ? 'all' : data[i];
                          });
                        },
                      )
                  ],
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
          25.ph,
          TextWidget(
            txt: selectedChip == 'all'
                ? 'All Products'
                : '${selectedChip.capitalize()} Products',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton(
                hint: TextWidget(txt: 'Limit'),
                value: int.parse(limit),
                menuMaxHeight: context.height * .3,
                borderRadius: BorderRadius.circular(15),
                items: List<DropdownMenuItem<int>>.generate(
                  21,
                  (index) {
                    return DropdownMenuItem<int>(
                      value: index,
                      child: Text(index.toString()),
                    );
                  },
                ),
                onChanged: (value) {
                  setState(() {
                    limit = value.toString();
                  });
                },
              ),
              IconButton(
                onPressed: () {
                  // 'desc' or 'asc'
                  setState(() {
                    sorted = sorted == 'asc' ? 'desc' : 'asc';
                  });
                },
                icon: Icon(Icons.sort),
              ),
            ],
          ),
          25.ph,
          SizedBox(
            // width: context.width * .8,
            // height: context.height * .1,
            child: Consumer(builder: (context, ref, child) {
              final prods = ref.watch(homeScreenProducts(fetchedData));
              return prods.when(
                data: (data) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                          context.push(ProductDetailsScreen(
                              id: data[index].id.toString()));
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Image.network(
                                data[index].image,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
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
              //   ListView.builder(
              //   scrollDirection: Axis.horizontal,
              //   itemCount: 3,
              //   itemBuilder: (context, index) {
              //     return Card(
              //       child: Container(
              //         width: context.width * .8,
              //         child: TextWidget(txt: 'txt $index'),
              //       ),
              //     );
              //   },
              // );
            }),
          ),
        ],
      ),
    );
  }
}
