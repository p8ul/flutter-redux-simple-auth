import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../presentation/login.dart';
import '../actions/actions.dart';
import '../models/app_state.dart';
import '../models/login.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, vm) {
        return LoginScreen(onSave: vm.onSave, login: vm.login);
      },
    );
  }
}

class _ViewModel {
  final Login login;
  final Function(
          String username, String email, String password, BuildContext context)
      onSave;

  _ViewModel({
    @required this.login,
    @required this.onSave,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        login: store.state.login,
        onSave: (username, email, password, context) {
          store.dispatch(LoginAction(Login(
              email: email,
              password: password,
              loading: true,
              callbackFn: () => {Navigator.pop(context)})));
        });
  }
}
