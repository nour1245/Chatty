import 'package:chatty/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required email,
    required password,
    required name,
    required phone,
  }) {
    emit(RegisterLoadState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(email: email, name: name, uId: value.user?.uid, phone: phone);
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required email,
    required name,
    required uId,
    required phone,
  }) {
    UserModel model = UserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      bio: 'write bio here',
      cover:
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
      image:
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
      isVerfied: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState(uId));
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

//obsecure password
  bool isPassword = true;
  var suffix = Icons.visibility;

  void showPassowrd() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ShowRPasswordState());
  }
}
