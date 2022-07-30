import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant/Controller/AuthController.dart';
import 'package:restaurant/Controller/UserController.dart';
import 'package:restaurant/Helpers/secure_storage.dart';
import 'package:restaurant/Models/Response/ResponseLogin.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<LoginEvent>(_onLogin);
    on<CheckLoginEvent>(_onCheckLogin);
    on<LogOutEvent>(_onLogOut);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingAuthState());

      final data =
          await authController.loginController(event.email, event.password);

      await Future.delayed(Duration(milliseconds: 850));

      if (data.success ?? false) {
        await secureStorage.deleteSecureStorage();
        await secureStorage.persistenToken(data.token!);
        await secureStorage.persistenUserId(data.user?.id ?? '');
       // await userController.updateNotificationToken();
        print(parseInt(data.user?.isAdmin.toString()));
        emit(state.copyWith(
            user: data.user, isAdmin: data.user!.isAdmin.toString()));
      } else {
        emit(FailureAuthState(data));
      }
    } catch (e) {
      emit(FailureAuthState(e.toString()));
    }
  }

  Future<void> _onCheckLogin(
      CheckLoginEvent event, Emitter<AuthState> emit) async {
    try {
     // emit(LoadingAuthState());

      if (await secureStorage.readToken() != null) {
        final data = await authController.renewLoginController();

        if (data.success ?? false) {
          await secureStorage.persistenToken(data.token!);
          emit(state.copyWith(
              user: data.user, isAdmin: data.user!.isAdmin.toString()));
        } else {
          emit(LogOutAuthState());
        }
      } else {
        print("no token");
        emit(LogOutAuthState());
      }
    } catch (e) {
      emit(FailureAuthState(e.toString()));
    }
  }

  Future<void> _onLogOut(LogOutEvent event, Emitter<AuthState> emit) async {
    await secureStorage.deleteSecureStorage();
    emit(LogOutAuthState());
    emit(state.copyWith(user: null, isAdmin: ''));
  }

  Object? parseInt(String? string) {
    if (string == null) {
      return null;
    }
    return string == "true" ? 1 : 0;
  }
}
