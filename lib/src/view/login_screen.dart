import 'package:appxemphim/src/bloc/login_bloc.dart';

import 'ListPhim.dart';
import 'package:appxemphim/src/view/register_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:progressive_image/progressive_image.dart';
import 'package:appxemphim/src/model/message.dart';
import '../model/Token.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> with WidgetsBindingObserver {
  late String account;
  late String password;
  LoginBloc lgbloc = new LoginBloc();
  Message message = new Message();
  late String token;
  final _accControllers = TextEditingController();
  final _pasControllers = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            ProgressiveImage(
              placeholder: AssetImage('assets/placeholder.jpg'),
              thumbnail: NetworkImage('https://i.imgur.com/7XL923M.jpg'),
              image: NetworkImage(
                  'https://png.pngtree.com/element_our/20190528/ourlarge/pngtree-film-film-image_1134583.jpg'),
              height: 300,
              width: 500,
            ),
            Text(
              "LOGIN",
              style: TextStyle(fontSize: 20),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: StreamBuilder(
                    stream: lgbloc.accStream,
                    builder: (context, snapshot) => TextField(
                        decoration: InputDecoration(
                          errorText: snapshot.hasError ? snapshot.error.toString() : null,
                          icon: Icon(
                            Icons.account_box,
                            size: 40,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),

                        ),
                        controller: _accControllers,
                        onChanged: (text) => {
                              setState(
                                () => {account = text},
                              )
                            }))),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: StreamBuilder(
                  stream: lgbloc.passStream,
                  builder: (context, snapshot) => TextField(
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.password_rounded,
                          size: 40,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        errorText:snapshot.hasError ? snapshot.error.toString() : null
                      ),
                      controller: _pasControllers,
                      onChanged: (text) => {
                            setState(
                              () => {password = text},
                            )
                          })),
            ),
            Container(
              margin: EdgeInsets.only(right: 40),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton.icon(
                      icon: Icon(Icons.edit, size: 32),
                      label: Text(
                        'Login',
                        style: TextStyle(fontSize: 10),
                      ),
                      onPressed: () async {
                        if(ValidatorUser()){
                          await Login(account, password);
                          print(message.message);
                          if (message.message != null) {
                            if (message.message == "ok") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListMoVie(
                                      token: token,
                                    )),
                              );
                            }
                          }
                        }
                      },
                    ),
                    ElevatedButton.icon(
                      icon: Icon(Icons.edit, size: 32),
                      label: Text(
                        'Register',
                        style: TextStyle(fontSize: 10),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool ValidatorUser(){
    if(lgbloc.isValidUser(account, password)){
      return true;
    }
    return false;
  }
  Future<Message> Login(String Account, String Password) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.16:5000/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Account': Account,
        'Password': Password,
      }),
    );

    if (response.statusCode == 200) {
      message = Message.fromJson(jsonDecode(response.body));
      token = Message.fromJson(jsonDecode(response.body)).token!.accessToken!;
      return Message.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  @override
  void initState() {}

  @override
  void dispose() {}
}
