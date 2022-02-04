import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shop_cubit/shop_states.dart';

class SettingsScreen extends StatelessWidget {
var nameController = TextEditingController();
var emailController = TextEditingController();
var phoneController = TextEditingController();
var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){
        if (state is ShopSuccessUserDataState){
          nameController.text = state.loginModel.data!.name.toString();
          emailController.text = state.loginModel.data!.email.toString();
          phoneController.text = state.loginModel.data!.phone.toString();
        }

      },
      builder: (context, state){
        var model = ShopCubit.get(context).userModel!;
        nameController.text = model.data!.name.toString();
        emailController.text = model.data!.email.toString();
        phoneController.text = model.data!.phone.toString();
        return  ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context)=>SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateDataState)
                    const LinearProgressIndicator(),
                    customFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value){
                          if(value.toString().isEmpty){
                            return 'Name must not be empty';
                          }
                        },
                        label: 'Name',
                        prefix:Icons.person),
                    const SizedBox(height: 20.0,),
                    customFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value){
                          if(value.toString().isEmpty){
                            return 'Email must not be empty';
                          }
                        },
                        label: 'Email',
                        prefix: Icons.email_outlined),
                    const SizedBox(height: 20.0,),
                    customFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (value){
                          if(value.toString().isEmpty){
                            return 'Phone must not be empty';
                          }
                        },
                        label: 'Phone',
                        prefix: Icons.phone),
                    const SizedBox(height: 40.0,),
                    const SizedBox(height: 40.0,),
                    defaultButton(buttonText: 'UPDATE', onPressed: (){
                      if (formKey.currentState!.validate()){
                        ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone:phoneController.text);
                      }

                    },
                        background: defaultColor),
                    const SizedBox(height: 20.0,),
                    defaultButton(buttonText: 'LOGOUT', onPressed: (){
                      signOut(context);
                    },
                    background: Colors.redAccent),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=>const Center(child: CircularProgressIndicator(),) ,
        );
      },

    );
  }
}
