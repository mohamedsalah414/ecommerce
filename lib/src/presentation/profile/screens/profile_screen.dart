import 'package:ecommercebusiness/src/core/utils/helper_extenstions.dart';
import 'package:ecommercebusiness/src/core/widgets/text_widget.dart';
import 'package:ecommercebusiness/src/presentation/cart/screens/cart_screen.dart';
import 'package:ecommercebusiness/src/presentation/login/screens/logIn_screen.dart';
import 'package:ecommercebusiness/src/presentation/product_details/screens/product_modify_screen.dart';
import 'package:ecommercebusiness/src/presentation/profile/viewmodel/profile_riverpod.dart';
import 'package:ecommercebusiness/src/presentation/profile/widgets/profile_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                context.pushAndRemoveUntil(const LogInScreen());
                SharedPreferencesService.getInstance()
                    .then((value) => value.clear());
              },
              icon: const Icon(Icons.logout),
              label: const TextWidget(txt: 'Log out')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Consumer(builder: (context, ref, child) {
              final profile = ref.watch(profileDetails);
              return profile.when(
                data: (data) {
                  return ProfileDetailsWidget(
                    data: data,
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
            50.ph,
            ElevatedButton.icon(
                onPressed: () {
                  context.push(const CartScreen());
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
                label: const TextWidget(
                  txt: 'My Cart',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            25.ph,
            ElevatedButton.icon(
                onPressed: () {
                  context.push(const ProductModifyScreen(type: 'create'));
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
                label: const TextWidget(
                  txt: 'Add Product',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
          ],
        ),
      ),
    );
  }
}
