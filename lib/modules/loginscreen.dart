import 'package:chatty/cubit/appcubit/social_cubit.dart';
import 'package:chatty/cubit/logincubit/login_cubit.dart';
import 'package:chatty/layout/lsocialayout.dart';
import 'package:chatty/modules/registerscreen.dart';
import 'package:chatty/shared/components/components.dart';
import 'package:chatty/shared/components/constants.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(msg: state.error, color: Colors.red);
          }
          if (state is LoginSuccessState) {
            box.put('uid', state.uid);
            uid = state.uid;
            SocialCubit.get(context).getUserData();
            navigatAndReplace(context, SocialLayout());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.black),
                        ),

                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                          'Login Now to Chat With Your Best Frindes!',
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        DefultTFF(
                          controrller: emailController,
                          keyboardtype: TextInputType.emailAddress,
                          label: 'Email',
                          prefix: Icons.email,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return ('Enter your email adress');
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        //textform field for password

                        DefultTFF(
                          controrller: passwordController,
                          keyboardtype: TextInputType.visiblePassword,
                          label: 'password',
                          isPassword: LoginCubit.get(context).isPassword,
                          suffix: LoginCubit.get(context).suffix,
                          onsubmit: () {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          suffixpresed: () {
                            LoginCubit.get(context).showPassowrd();
                          },
                          prefix: Icons.lock,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return ('Enter your password');
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // login button
                        ConditionalBuilder(
                          condition: state is! LoginLoadState,
                          builder: (BuildContext context) => DefultButtn(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'LOGIN',
                            isUperCase: true,
                          ),
                          fallback: (BuildContext context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 25,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('dont have an account?'),
                            TextButton(
                              onPressed: () {
                                navigatTO(context, RegisterScreen());
                              },
                              child: const Text(
                                'Create Now',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
