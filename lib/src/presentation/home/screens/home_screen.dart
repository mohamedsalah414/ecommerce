import 'package:ecommercebusiness/src/core/utils/helper_extenstions.dart';
import 'package:ecommercebusiness/src/core/widgets/text_widget.dart';
import 'package:ecommercebusiness/src/presentation/cart/screens/cart_screen.dart';
import 'package:ecommercebusiness/src/presentation/home/viewmodel/category_riverpod.dart';
import 'package:ecommercebusiness/src/presentation/home/viewmodel/products_riverpod.dart';
import 'package:ecommercebusiness/src/presentation/home/widgets/products_grid_widget.dart';
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
        title: const TextWidget(txt: 'Ecommerce'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
                child: IconButton(
                    onPressed: () {
                      context.push(const CartScreen());
                    },
                    icon: const Icon(Icons.shopping_cart))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
                child: IconButton(
                    onPressed: () {
                      context.push(const ProfileScreen());
                    },
                    icon: const Icon(Icons.person))),
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
                return buildWrapForCategories(data);
              },
              error: (error, stackTrace) {
                debugPrint(error.toString());
                return buildErrorText();
              },
              loading: () {
                return buildCircularIndicator();
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
          buildRowForLimitsAndSort(context),
          25.ph,
          Consumer(builder: (context, ref, child) {
            final prods = ref.watch(homeScreenProducts(fetchedData));
            return prods.when(
              data: (data) {
                return ProductsGridWidget(data: data);
              },
              error: (error, stackTrace) {
                debugPrint(error.toString());
                return buildErrorText();
              },
              loading: () {
                return buildCircularIndicator();
              },
            );
          }),
        ],
      ),
    );
  }

  Row buildRowForLimitsAndSort(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DropdownButton(
          hint: const TextWidget(txt: 'Limit'),
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
          icon: const Icon(Icons.sort),
        ),
      ],
    );
  }

  Center buildCircularIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Center buildErrorText() {
    return const Center(
      child: TextWidget(txt: 'Error'),
    );
  }

  Wrap buildWrapForCategories(List<String> data) {
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
                selectedChip = selectedChip == data[i] ? 'all' : data[i];
              });
            },
          )
      ],
    );
  }
}
