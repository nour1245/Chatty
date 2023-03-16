part of 'register_cubit.dart';

abstract class RegisterStates {}

class RegisterInitial extends RegisterStates {}

class RegisterLoadState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}

class CreateUserLoadState extends RegisterStates {}

class CreateUserSuccessState extends RegisterStates {
  final String uid;

  CreateUserSuccessState(this.uid);
}

class CreateUserErrorState extends RegisterStates {
  final String error;
  CreateUserErrorState(this.error);
}

class ShowRPasswordState extends RegisterStates {}
