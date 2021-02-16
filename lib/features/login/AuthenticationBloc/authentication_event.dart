part of 'authentication_bloc.dart';

class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  final String token;
  final String userName;
  LoggedIn({@required this.token,this.userName});
  @override
  String toString() {
    return "user logged in ${this.token} ,this.userName";
  }
  @override
  List<Object> get props => [this.token,this.userName];
}
class LoggedOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return "user logged out";
  }
}
