import 'dart:developer';
import 'package:http/http.dart' as http;
import 'ListPhim.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:appxemphim/src/model/message.dart';
import 'login_screen.dart';
class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> with WidgetsBindingObserver {
  late String account;
  late String password;
  late String phone;
  final _accControllers = TextEditingController();
  final _pasControllers = TextEditingController();
  final _phoControllers = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child :Column(children: <Widget>[
            Image.network(
                'https://png.pngtree.com/element_our/20190528/ourlarge/pngtree-film-film-image_1134583.jpg'),
            Text(
              "REGISTER",
              style: TextStyle(fontSize: 20,),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric( horizontal: 20),
                child: Text(
                  "Tên đăng nhập",
                  style: TextStyle(color: Colors.red),
                ),

              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical:5,horizontal: 20),
              child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.account_box,
                      size: 40,
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  controller: _accControllers,
                  onChanged: (text) => {
                    setState(
                          () => {account = text},
                    )
                  }),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Mật khẩu",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.password_rounded,
                      size: 40,
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  controller: _pasControllers,
                  onChanged: (text) => {
                    setState(
                          () => {password = text},
                    )
                  }),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric( horizontal: 20),
                child: Text(
                  "Nhập lại mật khẩu",
                  style: TextStyle(color: Colors.red),
                ),

              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.password_rounded,
                      size: 40,
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  controller: _pasControllers,
                  onChanged: (text) => {
                    setState(
                          () => {password = text},
                    )
                  }),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric( horizontal: 20),
                child: Text(
                  "Nhập số điện thoại",
                  style: TextStyle(color: Colors.red),
                ),

              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.password_rounded,
                      size: 40,
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  controller: _phoControllers,
                  onChanged: (text) => {
                    setState(
                          () => {phone = text},
                    )
                  }),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.edit, size: 32),
              label: Text(
                'Login',
                style: TextStyle(fontSize: 10),
              ),
              onPressed: () {
                print("$account,$password,$phone");
                createUser(account, password, phone);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Login()),
                );
              },
            )
          ]),
        )
      ),
    );
  }
  Future<Message>  createUser(String Account,String Password,String Phone) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.7:3000/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Account': Account,
        'Password': Password,
        'Phone': Phone
      }),
    );
    if (response.statusCode == 200) {

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
