// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/shop_layout.dart';
import 'package:shop_app/modules/login_screen/cubit/cubit.dart';
import 'package:shop_app/modules/login_screen/cubit/states.dart';
import 'package:shop_app/modules/register_screen/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status){
             CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token)
                 .then((value) {
                   token = state.loginModel.data!.token;
               navigateAndFinish(context, const ShopLayout());
             });
              print(state.loginModel.data!.token);
            }else{
             showToast(text: state.loginModel.message!, state: ToastsStates.ERROR);

            }
          }
        },
        builder: (context, state) {
          ShopLoginCubit cubit = BlocProvider.of(context);
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
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 34.0,
                            fontWeight: FontWeight.bold,
                            color: defaultColor
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        const Text(
                          'login now to browse our hot offers',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        customFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            isPassword: false,
                            validate: (value) {
                              if (value.toString().isEmpty) {
                                return 'email address must not be empty';
                              }
                            },
                            label: 'Email address',
                            prefix: Icons.email_outlined),
                        const SizedBox(
                          height: 15.0,
                        ),
                        customFormField(
                            controller: passwordController,
                            isPassword: cubit.isPassword,
                            type: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value.toString().isEmpty) {
                                return 'Password is too short';
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock_outline,
                            suffix: cubit.suffix,
                            onPressed: () {
                              cubit.changeVisibility();
                            }),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultButton(
                            buttonText: 'login',
                            isUpperCase: true,
                            textSize: 18,
                            onPressed: () {
                              if (state is! ShopLoginLoadingState) {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              }
                              else {
                                const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?', style: TextStyle(
                              color:Colors.black,
                              fontWeight: FontWeight.bold
                            ),),
                            defaultTextButton(
                              text: 'register',
                                onPressed: () {
                                  navigateTo(context, const RegisterScreen());
                                },
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
