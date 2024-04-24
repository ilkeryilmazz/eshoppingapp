import 'package:bloc/bloc.dart';
import 'package:eshopping/model/login_request_model.dart';
import 'package:eshopping/model/login_response_model.dart';
import 'package:eshopping/service/IAuthService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey = GlobalKey();
  bool isLoginFail = false;
  final IAuthService service;
  bool isLoading = false;
  LoginCubit( this.emailController, this.passwordController,
      {required this.service})
      : super(LoginInitial());

  Future<void> postUserModel() async {
    if (formKey.currentState !=null && formKey.currentState!.validate()) {
     
      changeLoadingView();
      final data = await service.postUserLogin(LoginRequestModel(email: emailController.text.trim(),password: passwordController.text.trim()));
      
      if (data is LoginResponseModel) {
       if (data.success==true) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove("userId");
        await prefs.setInt("userId",data.data!.id!.toInt());
          emit(LoginComplate(data));
       }
      }
      await Future.delayed(Duration(seconds: 1));
      changeLoadingView();
    } else {
      isLoginFail = true;
      emit(LoginValidateState(isLoginFail));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(LoginLoadingState(isLoading));
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {
  final bool isLoading;
  LoginLoadingState(this.isLoading);
}
class LoginComplate extends LoginState {
  final LoginResponseModel model;

  LoginComplate( this.model);

 
}

class LoginValidateState extends LoginState {
  final bool isValidate;

  LoginValidateState(this.isValidate);
}
