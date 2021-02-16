part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  String userName;
  AuthenticationAuthenticated(this.userName);
  @override
  List<Object> get props => [this.userName];
}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationFail extends AuthenticationState {
  String error;
  AuthenticationFail(this.error);
  @override
  List<Object> get props => [this.error];
}