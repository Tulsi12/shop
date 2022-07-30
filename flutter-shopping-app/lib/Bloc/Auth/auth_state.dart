part of 'auth_bloc.dart';

@immutable
class AuthState {
  final User? user;
  final String isAdmin;

  const AuthState({this.user, this.isAdmin = ''});

  AuthState copyWith({User? user, String? isAdmin}) =>
      AuthState(user: user ?? this.user, isAdmin: isAdmin ?? this.isAdmin);
}

class LoadingAuthState extends AuthState {}

class SuccessAuthState extends AuthState {}

class LogOutAuthState extends AuthState {}

class FailureAuthState extends AuthState {
  final error;
  FailureAuthState(this.error);
}
