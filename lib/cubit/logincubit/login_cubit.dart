import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required email,
    required password,
  }) {
    emit(LoginLoadState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

//obsecure password
  bool isPassword = true;
  var suffix = Icons.visibility;

  void showPassowrd() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ShowPasswordState());
  }
}
