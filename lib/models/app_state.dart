import 'package:meta/meta.dart';
import './model.dart';

@immutable
class AppState {
  final bool isLoading;
  final Login login;

  AppState({this.isLoading = false, this.login});

  factory AppState.init() => AppState(
      isLoading: true, login: Login.fromJson({'loading': false, 'error': ''}));

  AppState copyWith({
    bool isLoading,
    Login login
  }) {
    return AppState(isLoading: isLoading ?? this.isLoading, login: login ?? this.login);
  }

  @override
  String toString() {
    return 'AppState{login: $login';
  }
}
