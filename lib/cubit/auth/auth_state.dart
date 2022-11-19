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