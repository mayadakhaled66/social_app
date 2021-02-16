part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}
class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}
class LoginSuccessState extends LoginState {
  UserInfo userInfo;
  LoginSuccessState(this.userInfo);
  @override
  List<Object> get props => [this.userInfo];
}
class LogOutSuccessState extends LoginState {
  LogOutSuccessState();
  @override
  List<Object> get props => [];
}
class LoginFail extends LoginState {
  final String error;
  LoginFail({this.error});
  @override
  List<Object> get props => [this.error];
}
