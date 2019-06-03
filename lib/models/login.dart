class Login {
  final String email;
  final String password;
  final String token;
  final String error;
  final bool loading;
  final Function callbackFn;

  Login(
      {this.email = '',
      this.password = '',
      this.token = '',
      this.loading = false,
      this.callbackFn,
      this.error: ''});

  Login copyWith({String email, String password}) {
    return Login(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'Login{email: $email, password: $password';
  }

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
        email: json['email'],
        token: json['token'],
        loading: json['loading'] ?? false,
        error: json['error'] ?? '');
  }
}
