part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}
class LoginButtonPressed extends LoginEvent{
  final String userName;
  final String password;
  LoginButtonPressed({@required this.userName,@required this.password});

  @override
  List<Object> get props => [this.userName,this.password];

  @override
  String toString() {
    return 'login button is pressed with user name ${this.userName} and password ${this.password}';
  }

}
class LogOutButtonPressed extends LoginEvent{
  // final String userName;
  // final String password;
  // LogOutButtonPressed({@required this.userName,@required this.password}password);

  @override
  List<Object> get props => [];
  // this.userName,this.password

  @override
  String toString() {
    return 'logout';
  }

}