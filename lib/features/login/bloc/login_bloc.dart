import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:preventia_app/features/Repos/UserReposatiry.dart';
import 'package:preventia_app/features/Utilities/UserInfo.dart';
import 'package:preventia_app/features/login/AuthenticationBloc/authentication_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;
  AuthenticationBloc authenticationBloc =AuthenticationBloc();

  LoginBloc({this.authenticationBloc, this.userRepository})
      : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      try {
        yield LoginLoading();
        final token = await UserRepository().authenticate(
            password: event.password, username: event.userName);
        if (token != null) {
          AuthenticationBloc().add(LoggedIn(token: token,userName: event.userName));
        }
        yield LoginSuccessState(UserInfo(firstName: event.userName));
      } catch (error) {
        yield LoginFail(error: error.toString());
      }
    }else if  (event is LogOutButtonPressed) {
      try {
        yield LoginLoading();

        // if (token != null) {
          await AuthenticationBloc().add(LoggedOut());
        // }
        yield LogOutSuccessState();
      } catch (error) {
        yield LoginFail(error: error.toString());
      }
    }
  }
}


