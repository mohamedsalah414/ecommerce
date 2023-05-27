import 'package:dio/dio.dart';
import 'package:ecommercebusiness/src/core/utils/helper_extenstions.dart';
import 'package:ecommercebusiness/src/core/widgets/text_widget.dart';
import 'package:ecommercebusiness/src/presentation/home/screens/home_screen.dart';
import 'package:ecommercebusiness/src/presentation/login/viewmodel/login_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/app_colors.dart';
import 'text_field_widget.dart';

class BuildFormLogIn extends StatelessWidget {
  const BuildFormLogIn({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldLogIn(
                    controller: _emailController,
                    isPassword: false,
                    title: 'email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid mail';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name),
                25.ph,
                TextFieldLogIn(
                    controller: _passwordController,
                    isPassword: true,
                    title: 'password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid password';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword),
                20.ph,
                Consumer(builder: (context, ref, child) {
                  final log = ref.watch(login);
                  return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ///username : mor_2314 password: 83r5^_
                          _formKey.currentState!.save();
                          log
                              .logIn(_emailController.text,
                                  _passwordController.text)
                              .then((value) {
                            if (value.statusCode == 200) {
                              context.pushAndRemoveUntil(
                                const HomeScreen(),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      const Icon(
                                        Icons.thumb_up_alt_rounded,
                                        color: Colors.white54,
                                      ),
                                      10.pw,
                                      const TextWidget(txt: 'Sign in Success'),
                                    ],
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          }).onError((DioError error, stackTrace) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    const Icon(
                                      Icons.error,
                                      color: Colors.white54,
                                    ),
                                    10.pw,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                            txt: 'Sign in ${error.response}'),
                                      ],
                                    ),
                                  ],
                                ),
                                backgroundColor: AppColor.pink,
                              ),
                            );
                            debugPrint(
                                'onError logIn ${error.response!.data['message']}');
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          backgroundColor: AppColor.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: const TextWidget(
                        txt: 'Sign in',
                        color: AppColor.white,
                        fontSize: 18,
                      ));
                }),
                20.ph,
                TextButton(
                    onPressed: () {
                      context.pushAndRemoveUntil(
                        const HomeScreen(),
                      );
                    },
                    child: const TextWidget(
                      txt: 'Login with any single user',
                      color: AppColor.prussianBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    )),
                70.ph,
                // const TextWidget(
                //   txt:
                //       '*note you can login and take a token from server with username mor_2314 and password 83r5^_\nalso you can use app without login',
                //   color: AppColor.prussianBlue,
                //   fontWeight: FontWeight.w700,
                //   fontSize: 15,
                // )
              ],
            )),
      ),
    );
  }
}
