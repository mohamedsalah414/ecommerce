import 'package:ecommercebusiness/src/core/widgets/text_widget.dart';
import 'package:ecommercebusiness/src/modules/cart/presentation/screens/cart_screen.dart';
import 'package:ecommercebusiness/src/modules/cart/presentation/viewmodel/cart_riverpod.dart';
import 'package:ecommercebusiness/src/modules/home/presentation/screens/products/products_screen.dart';
import 'package:ecommercebusiness/src/modules/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({Key? key}) : super(key: key);

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(txt: 'Ecommerce'),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: CircleAvatar(
        //         child: IconButton(
        //             onPressed: () {
        //               context.push(const CartScreen());
        //             },
        //             icon: const Icon(Icons.shopping_cart))),
        //   ),
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: CircleAvatar(
        //         child: IconButton(
        //             onPressed: () {
        //               context.push(const ProfileScreen());
        //             },
        //             icon: const Icon(Icons.person))),
        //   ),
        // ],
      ),
      body: <Widget>[
        const HomeScreen(),
        const CartScreen(),
        const ProfileScreen(),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          const NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Consumer(
              builder: (context, ref, child) {
                final cartAddition = ref.watch(cart);
                return Badge(
                    isLabelVisible: cartAddition.quantityForProducts != 0,
                    label:
                        TextWidget(txt: '${cartAddition.quantityForProducts}'),
                    child: const Icon(Icons.shopping_cart));
              },
            ),
            label: 'Cart',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
