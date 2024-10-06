part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoginLoading extends UserState {}

class UserLoginSuccess extends UserState {
  final AuthResponse authResponse;
  const UserLoginSuccess({required this.authResponse});
}

class UserLoginError extends UserState {
  final String message;
  const UserLoginError({required this.message});
}

class UserRegisterLoading extends UserState {}

class UserRegisterSuccess extends UserState {
  final AuthResponse authResponse;
  const UserRegisterSuccess({required this.authResponse});
}

class UserRegisterError extends UserState {
  final String message;
  const UserRegisterError({required this.message});
}
