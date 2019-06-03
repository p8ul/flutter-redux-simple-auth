import 'package:redux/redux.dart';
import '../actions/actions.dart';
import '../models/model.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/index.dart';

String url = 'http://10.10.160.37:3000/login';

List<Middleware<AppState>> createStoreMiddleware() {
  final loginUser = _loginUser();

  return [
    TypedMiddleware<AppState, LoginAction>(loginUser),
    new LoggingMiddleware.printer()
  ];
}

Middleware<AppState> _loginUser() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);
    final Login login = store.state.login;
    Map map = {'email': login.email, 'password': login.password};
    
    _callback () {
      print('failed to login');
      store.dispatch(ChangeLoginAction(Login(error: 'Email or password is incorrect', loading: false)));
    }
    final res = await apiClient(url, map, _callback);

    final response = res;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString('token');
    if (response != null && response.token != null) {
      login.callbackFn(); // login succesfull pop screen 
      store.dispatch(ChangeLoginAction(Login(loading: false)));
      await prefs.setString('token', response.token);
    }
    // print(store.state);
  };
}