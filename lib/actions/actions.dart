import '../models/model.dart';

class LoginAction {
  final Login login;

  LoginAction(this.login);

  @override
  String toString() {
    return 'LoginAction{Action: $login';
  }
}

class ChangeLoginAction {
  final Login login;

  ChangeLoginAction(this.login);

  @override
  String toString() {
    return 'ChangeLoginAction{Action: $login';
  }
}