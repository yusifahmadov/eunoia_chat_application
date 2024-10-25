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

class UserDetailLoading extends UserState {}

class UserDetailSuccess extends UserState {
  final List<User> users;
  const UserDetailSuccess({required this.users});
}

class UserDetailError extends UserState {
  final String message;
  const UserDetailError({required this.message});
}
