part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class UserLoginInit extends AuthState {}

class UserLoginSuccessful extends AuthState {
  final UserModel userData;
  final String? message;

  const UserLoginSuccessful({this.message, required this.userData});
}

class UserLoginFailed extends AuthState {
  final String message;

  const UserLoginFailed({required this.message});
}

class UserRegisterInit extends AuthState {}

class UserRegisterSuccessful extends AuthState {
  final UserModel userData;
  final String? message;

  const UserRegisterSuccessful({this.message, required this.userData});
}

class UserRegisterFailed extends AuthState {
  final String message;

  const UserRegisterFailed({required this.message});
}