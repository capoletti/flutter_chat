import 'dart:io';

enum AuthMode { singup, login }

class AuthFormData {
  String name = '';
  String email = '';
  String password = '';
  File? image;

  AuthMode _mode = AuthMode.login;

  bool get isLogin {
    return _mode == AuthMode.login;
  }

  bool get isSingup {
    return _mode == AuthMode.singup;
  }

  void toggleAuthMode() {
    _mode = isLogin ? AuthMode.singup : AuthMode.login;
  }
}
