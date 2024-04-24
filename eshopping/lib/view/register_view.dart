import 'package:dio/dio.dart';
import 'package:eshopping/service/auth_service.dart';
import 'package:eshopping/view/bottom_navigation_bar.dart';
import 'package:eshopping/view/product_list_view.dart';

import 'package:eshopping/viewmodel/login_cubit.dart';
import 'package:eshopping/viewmodel/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class RegisterView extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
          formKey, emailController, passwordController,userNameController,
          service: AuthService(
              Dio(BaseOptions(baseUrl: "https://10.0.2.2:7196/api", receiveDataWhenStatusError: true)))),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterComplate) {
             Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigationBarView(null)));
          }
        },
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context, RegisterState state) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Center(child: Text("E-Shopping App")),
      ),
      body: context.watch<RegisterCubit>().isLoading == true ? Center(child: CircularProgressIndicator()) :  Form(
        key: formKey,
        autovalidateMode: state is RegisterValidState
            ? (state.isValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled)
            : AutovalidateMode.disabled,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(
                AppLocalizations.of(context)!.welcome,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: [
                buildTextFormFieldUserName(context),
                buildTextFormFieldLogin(context),
                buildTextFormFieldPassword(context),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary),
                    onPressed: () {
                      context.read<RegisterCubit>().postUserModel();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.register,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    )),
                    Text(AppLocalizations.of(context)!.or, style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary),
                    onPressed: () {
                      Navigator.pop(context, MaterialPageRoute(builder: (context) => RegisterView()));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding buildTextFormFieldUserName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20, top: 20),
      child: TextFormField(
        validator: (value) => value!.length < 1 ? AppLocalizations.of(context)!.enterUsernameError: null,
        controller: userNameController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            prefixIconColor: Theme.of(context).colorScheme.background,
            fillColor: Theme.of(context).colorScheme.primary,
            prefixIcon: Icon(Icons.person),
            hintText: AppLocalizations.of(context)!.userName),
      ),
    );
  }
  Padding buildTextFormFieldPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20, top: 20),
      child: TextFormField(
        obscureText: true,
        controller: passwordController,
         validator: (value)=> value!.length < 1? AppLocalizations.of(context)!.password : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            
            prefixIconColor: Theme.of(context).colorScheme.background,
            fillColor: Theme.of(context).colorScheme.primary,
            prefixIcon: Icon(Icons.lock),
            hintText: AppLocalizations.of(context)!.password),
      ),
    );
  }

  Padding buildTextFormFieldLogin(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20, top: 20),
      child: TextFormField(
        controller: emailController,
        validator: (value)=>  validateEmail(value, context),
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            prefixIconColor: Theme.of(context).colorScheme.background,
            fillColor: Theme.of(context).colorScheme.primary,
            prefixIcon: Icon(Icons.email),
            hintText: AppLocalizations.of(context)!.email),
      ),
    );
  }
  String? validateEmail(String? value, BuildContext context) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  return value!.isNotEmpty && !regex.hasMatch(value)
      ? AppLocalizations.of(context)!.enterEmailError
      : null;
}
}
