import 'package:bloc/bloc.dart';

import 'package:eshopping/model/register_request_model.dart';
import 'package:eshopping/model/register_response_model.dart';
import 'package:eshopping/service/IAuthService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController userNameController;
  final GlobalKey<FormState> formKey;
  bool isRegisterFail = false;
  final IAuthService service;
  bool isLoading = false;
  RegisterCubit(this.formKey, this.emailController, this.passwordController, this.userNameController,
      {required this.service})
      : super(RegisterInitial());

  Future<void> postUserModel() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      
      changeLoadingView();
      final data = await service.postUserRegister(RegisterRequestModel(
          id: 0,
          userName: userNameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim()));
      await Future.delayed(Duration(seconds: 1));
      if (data is RegisterResponseModel) {
       
         if (data.success==true) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove("userId");
        await prefs.setInt("userId",data.data!.id!.toInt());
          emit(RegisterComplate(data));
       }
      }
      changeLoadingView();
    } else {
      isRegisterFail = true;
      emit(RegisterValidState(isRegisterFail));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(RegisterLoadingState(isLoading));
  }
}

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {
  final bool isLoading;
  RegisterLoadingState(this.isLoading);
}

class RegisterComplate extends RegisterState {
  final RegisterResponseModel model;

  RegisterComplate(this.model);
}

class RegisterValidState extends RegisterState {
  final bool isValidate;

  RegisterValidState(this.isValidate);
}
