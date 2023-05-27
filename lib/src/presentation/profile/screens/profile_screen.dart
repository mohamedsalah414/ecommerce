import 'package:ecommercebusiness/src/core/utils/helper_extenstions.dart';
import 'package:ecommercebusiness/src/core/widgets/text_widget.dart';
import 'package:ecommercebusiness/src/presentation/cart/screens/cart_screen.dart';
import 'package:ecommercebusiness/src/presentation/login/screens/logIn_screen.dart';
import 'package:ecommercebusiness/src/presentation/product_details/screens/product_modify_screen.dart';
import 'package:ecommercebusiness/src/presentation/profile/viewmodel/profile_riverpod.dart';
import 'package:flutter/cupertino.dart';
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
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Consumer(builder: (context, ref, child) {
              final profile = ref.watch(profileDetails);
              return profile.when(
                data: (data) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        child: Icon(
                          CupertinoIcons.profile_circled,
                          size: 150,
                        ),
                      ),
                      25.ph,
                      TextWidget(
                        txt: '${data.name.firstname} ${data.name.lastname}',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      10.ph,
                      TextWidget(
                        txt: 'Email: ${data.email}',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      10.ph,
                      TextWidget(
                        txt: 'Phone: ${data.phone}',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      10.ph,
                      TextWidget(
                        txt: 'Address:',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      5.ph,
                      TextWidget(
                        txt:
                            '${data.address.number}, ${data.address.street}, ${data.address.city}, ${data.address.zipcode}',
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                      ),
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
            50.ph,
            ElevatedButton.icon(
                onPressed: () {
                  context.push(CartScreen());
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
