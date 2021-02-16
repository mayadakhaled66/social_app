import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '';
import 'package:preventia_app/features/Repos/UserReposatiry.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  UserRepository userRepository;
  AuthenticationBloc({this.userRepository}) : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event,) async* {
    
    if(event is AppStarted){
      bool hasToken = await UserRepository().hasToken();
      if(hasToken){
        yield AuthenticationAuthenticated("");
      }else{
        yield AuthenticationUnauthenticated();
      }
    }
    if(event is LoggedIn){
      yield AuthenticationLoading();
      await UserRepository().persistToken(token:event.token,userName:event.userName);
      yield AuthenticationAuthenticated(event.userName);
    }
    if (event is LoggedOut){
      yield AuthenticationLoading();
     bool loggedOut =await UserRepository().deleteToken();
     if(loggedOut){
       yield AuthenticationUnauthenticated();
     }else{
       yield AuthenticationFail("Try again");
     }

    }

  }
}
