import 'package:redux/redux.dart';
import '../actions/actions.dart';
import '../models/model.dart';

final loginReducer = combineReducers<Login>([
  TypedReducer<Login, LoginAction>(_loginUserReducer),
  TypedReducer<Login, ChangeLoginAction>(_changeLoginReducer),
]);

Login _loginUserReducer(Login login, LoginAction action) {
  return action.login ?? Login(email: '', password: '');
}

Login _changeLoginReducer(Login login, ChangeLoginAction action) {
  return action.login;
}