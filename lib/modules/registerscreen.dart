import 'package:chatty/cubit/appcubit/social_cubit.dart';
import 'package:chatty/cubit/registercubit/register_cubit.dart';
import 'package:chatty/layout/lsocialayout.dart';
import 'package:chatty/shared/components/components.dart';
import 'package:chatty/shared/components/constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  var formKey2 = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
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
                    key: formKey2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.black),
                        ),

                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                          'Register now to Chat with Best Friends',
                        ),

                        const SizedBox(
                          height: 30.0,
                        ),
                        DefultTFF(
                          controrller: nameController,
                          keyboardtype: TextInputType.name,
                          label: 'Name',
                          prefix: Icons.perm_identity,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return ('Enter your name');
                            }
                          },
                        ),

                        const SizedBox(
                          height: 15.0,
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
                        //textform field for phone
                        DefultTFF(
                          controrller: phoneController,
                          keyboardtype: TextInputType.phone,
                          label: 'phone',
                          prefix: Icons.email,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return ('Enter your phone  ');
                            }
                          },
                        ),

                        const SizedBox(
                          height: 15.0,
                        ),

                        //password form field
                        DefultTFF(
                          controrller: passwordController,
                          keyboardtype: TextInputType.visiblePassword,
                          label: 'password',
                          isPassword: RegisterCubit.get(context).isPassword,
                          suffix: RegisterCubit.get(context).suffix,
                          onsubmit: () {
                            if (formKey2.currentState!.validate()) {
                              RegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          suffixpresed: () {
                            RegisterCubit.get(context).showPassowrd();
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
                        // Register button
                        ConditionalBuilder(
                          condition: state is! RegisterLoadState,
                          builder: (BuildContext context) => DefultButtn(
                            function: () {
                              if (formKey2.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'Register',
                            isUperCase: true,
                          ),
                          fallback: (BuildContext context) =>
                              const Center(child: CircularProgressIndicator()),
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
