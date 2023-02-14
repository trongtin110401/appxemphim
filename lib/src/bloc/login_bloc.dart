
import 'dart:async';
import 'package:appxemphim/src/validators/login/validator_login.dart';
class LoginBloc {
  StreamController _accountController = new StreamController();
  StreamController _passwordController = new StreamController();
  Stream get accStream => _accountController.stream;
  Stream get passStream => _passwordController.stream;
  bool isValidUser(String acc,String pass){
    if(!ValidationLogin.isValidAccount(acc) ){
      _accountController.sink.addError("Tài khoản không hợp lệ");
      return false;
    }
    _accountController.sink.add("OK");
    if(!ValidationLogin.isValidPassWord(pass)){
      _passwordController.sink.addError("Mật khẩu không hợp lệ");
      return false;
    }
    _passwordController.sink.add("OK");
    return true;
  }
  void dispose(){
    _accountController.close();
    _passwordController.close();
  }
}