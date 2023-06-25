import 'package:ecommercebusiness/src/core/services/shared_preferences.dart';
import 'package:ecommercebusiness/src/core/utils/app_colors.dart';
import 'package:ecommercebusiness/src/core/utils/helper_extenstions.dart';
import 'package:ecommercebusiness/src/core/widgets/text_widget.dart';
import 'package:ecommercebusiness/src/modules/login/presentation/screens/logIn_screen.dart';
import 'package:ecommercebusiness/src/modules/product_details/presentation/screens/product_modify_screen.dart';
import 'package:ecommercebusiness/src/modules/profile/presentation/viewmodel/profile_riverpod.dart';
import 'package:ecommercebusiness/src/modules/profile/presentation/widgets/profile_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
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
            // ElevatedButton.icon(
            //     onPressed: () {
            //       context.push(const CartScreen());
            //     },
            //     icon: const Icon(
            //       Icons.shopping_cart,
            //       size: 30,
            //     ),
            //     label: const TextWidget(
            //       txt: 'My Cart',
            //       fontWeight: FontWeight.bold,
            //       fontSize: 20,
            //     )),
            // 25.ph,
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
            25.ph,
            ElevatedButton.icon(
                onPressed: () {
                  context.pushAndRemoveUntil(const LogInScreen());
                  SharedPreferencesService.getInstance()
                      .then((value) => value.clear());
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.carolinaBlue),
                icon: const Icon(
                  Icons.logout,
                  size: 30,
                ),
                label: const TextWidget(
                  txt: 'Log out',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
          ],
        ),
      ),
    );
  }
}
